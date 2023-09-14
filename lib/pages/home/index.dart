import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/tools/geo_location.dart';
import 'package:shoppingchk/tools/localization.dart';
import 'package:shoppingchk/widget/shop_item.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchQueryController = TextEditingController();
  final Localization localization = Localization.instance;

  List<Shop> shops = [];
  List<Shop> orginalShopList = [];
  late Position geoPosition;
  bool isLoading = true;

  static const int _searchFetchingSeconds = 2;
  DateTime? _latestInputTime;
  Timer? _latestWaitFetchFuture;

  void getGEOShopList() async {
    String? geoHash;

    try {
      Position position = await GEOLocation.instasnce.determinePosition();
      geoHash = GEOLocation.instasnce.hash(position);
    } catch (error) {
      geoHash = null;
    }

    Amplify.DataStore.query(Shop.classType,
        where: (geoHash != null)
            ? Shop.AVAILABLE.eq(true).and(Shop.GEOHASH.beginsWith(geoHash))
            : Shop.AVAILABLE.eq(true),
        pagination: const QueryPagination(limit: 20),
        sortBy: [
          QuerySortBy(
              field: Shop.ID.fieldName, order: QuerySortOrder.descending)
        ]).then((shopList) {
      setState(() {
        shops = shopList;
        isLoading = false;
      });
    });
    orginalShopList = List.from(shops);
  }

  @override
  void initState() {
    super.initState();
    getGEOShopList();

    //setState(() {
    //  shops = [
    //    Shop(
    //        id: "123123123id",
    //        name: "test",
    //        address: "testsetsetatesatset",
    //        available: true),
    //    Shop(
    //        id: "123123123id",
    //        name: "test",
    //        address: "testsetsetatesatset",
    //        available: true)
    //  ];

    //  orginalShopList = List.from(shops);
    //  isLoading = false;
    //});
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    _latestWaitFetchFuture?.cancel();
    super.dispose();
  }

  void searchShop(String searchValue) {
    if (searchValue.isEmpty) {
      setState(() {
        shops = orginalShopList;
      });

      return;
    }

    setState(() {
      shops = [];
    });

    if (_latestInputTime != null && _latestWaitFetchFuture != null) {
      if (DateTime.now().second - _latestInputTime!.second <
          _searchFetchingSeconds) {
        _latestWaitFetchFuture!.cancel();
      }
    }

    _latestInputTime = DateTime.now();
    _latestWaitFetchFuture =
        Timer(const Duration(seconds: _searchFetchingSeconds), () {
      Amplify.DataStore.query(Shop.classType,
              where: Shop.AVAILABLE.eq(true).and(Shop.NAME.eq(searchValue)))
          .then((shopList) => shops = shopList);
    });
  }

  Widget _header() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "ShoppingChk",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.wysiwyg_rounded),
          onPressed: () => context.push("/request/1"),
        )
      ],
      titleTextStyle:
          const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    );
  }

  Widget _main() {
    return RWDLayout(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => searchShop(value.trim()),
              controller: _searchQueryController,
              decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: localization.get(context).placeholderSearch,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: (!isLoading)
                  ? ListView.builder(
                      itemCount: shops.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ShopItem(shop: shops[index]);
                      })
                  : const Text("loading"),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: ListView(
          children: [_header(), _main()],
        )));
  }
}
