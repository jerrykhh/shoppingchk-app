import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/widget/shop_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchQueryController = TextEditingController();
  late List<Shop> shops;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shops = [
      Shop(
          id: "123123123id",
          name: "test",
          address: "testsetsetatesatset",
          available: true),
      Shop(
          id: "123123123id",
          name: "test",
          address: "testsetsetatesatset",
          available: true)
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchQueryController.dispose();
    super.dispose();
  }

  Widget _header() {
    return AppBar(
      centerTitle: true,
      title: const Text("ShoppingChk"),
      titleTextStyle:
          const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    );
  }

  Widget _main() {
    return RWDLayout(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextField(
              controller: _searchQueryController,
              decoration: const InputDecoration(
                focusColor: Colors.black,
                hintText: 'Please Search here...',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ListView.builder(
                  itemCount: shops.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ShopItem(shop: shops[index]);
                  }),
            ),
          ]),
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
