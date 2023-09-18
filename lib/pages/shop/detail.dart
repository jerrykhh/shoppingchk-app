import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/widget/comment_item.dart';

class ShopDetailPage extends StatefulWidget {
  final String id;
  const ShopDetailPage({super.key, required this.id});

  @override
  State<ShopDetailPage> createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  // Future<Shop> _shop;

  Future<Shop> fetchShop() async {
    Shop shop = (await Amplify.DataStore.query(Shop.classType,
            where: Shop.ID.eq(widget.id)))
        .first;
    return shop;
  }

  Future<List<Comment>> fetchComment() async {
    List<Comment> comments = (await Amplify.DataStore.query(Comment.classType,
        where: Comment.APPROVED.eq(true).and(Comment.SHOPID.eq(widget.id))));
    return comments;
  }

  @override
  void initState() {
    super.initState();
    // fetchShop();
    //queryShop(widget.id).then((value) => setState(() => _shop = value));
    // setState(() {
    //_shop = Shop(
    //    name: "nameasdfadfasdf0923rjoidfjasdklfj0392dfghdfghdfghdfghfdgj",
    //    address: "address",
    //    available: true);

    // _comment = [
    //   Comment(
    //       userId: "1",
    //       description: "description",
    //       rate: CommentRate.NEUTRAL,
    //       approved: true,
    //       shopID: "123213312123312312312"),
    //   Comment(
    //       userId: "1",
    //       description:
    //           "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
    //       rate: CommentRate.GOOD,
    //       approved: true,
    //       shopID: "123213312123312312312"),
    //   Comment(
    //       userId: "1",
    //       description: "description",
    //       rate: CommentRate.NEGATIVE,
    //       approved: true,
    //       shopID: "123213312123312312312"),
    // ];
    // });
  }

  AppBar _appbar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text("Shop - $title"),
    );
  }

  Widget _shopRating(Shop shop) {
    return Container(
      height: 80.0,
      alignment: Alignment.center,
      child: Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ((2.0 * shop.rate_good_count * 1.0 * shop.rate_neutral_count +
                            -3.0 * shop.rate_negative_count) /
                        (shop.rate_good_count +
                            shop.rate_negative_count +
                            shop.rate_neutral_count) *
                        5)
                    .floorToDouble()
                    .toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 32.0),
              ),
              const VerticalDivider(
                width: 30.0,
                thickness: 0,
              ),
              Column(
                children: [
                  Text(
                    shop.rate_negative_count.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "negative",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              ),
              const VerticalDivider(
                width: 30.0,
                thickness: 0.3,
              ),
              Column(
                children: [
                  Text(shop.rate_neutral_count.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const Text(
                    "neutral",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              ),
              const VerticalDivider(
                width: 30.0,
                thickness: 0.3,
              ),
              Column(
                children: [
                  Text(shop.rate_good_count.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const Text(
                    "good",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget _shopDetail(Shop shop) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 15.0),
          color: Colors.black12,
          child: (shop.icon == null || shop.icon == "")
              ? Icon(
                  Icons.store_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 26,
                )
              : Image.network(
                  shop.icon!,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            shop.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            shop.address,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
          ),
        )
      ]),
    );
  }

  Widget _shopComment(List<Comment>? comment) {
    return ListView.builder(
      itemCount: comment!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CommentItem(comment: comment[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: FutureBuilder(
    //         future: _shop,
    //         builder: (BuildContext context, AsyncSnapshot<Shop> snapshot) {
    //           final item = snapshot.data;
    //           return Text(item!.name);
    //         }));

    return FutureBuilder(
        future: fetchShop(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final shop = snapshot.data;
            return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: _appbar(shop!.name),
                body: RWDLayout(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      _shopDetail(shop),
                      _shopRating(shop),
                      FutureBuilder(
                          future: fetchComment(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<Comment>? comments = snapshot.data;
                              return _shopComment(
                                  (comments == null) ? [] : comments);
                            }
                            return Container(
                              height: 80,
                              width: 80,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          })
                    ],
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                    color: Colors.white,
                    height: 60.0,
                    child: FilledButton(
                        onPressed: () => context.go(
                            "/shop/${widget.id}/request",
                            extra: {'shopID': widget.id}),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Write a Comment",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))));
          }
          return const CircularProgressIndicator();
        });
  }
}
