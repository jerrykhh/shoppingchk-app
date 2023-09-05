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
  late Shop _shop;
  late List<Comment> _comment;

  @override
  void initState() {
    super.initState();
    //queryShop(widget.id).then((value) => setState(() => _shop = value));
    _shop = Shop(
        name: "nameasdfadfasdf0923rjoidfjasdklfj0392dfghdfghdfghdfghfdgj",
        address: "address",
        available: true);

    _comment = [
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEUTRAL,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description:
              "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
          rate: CommentRate.GOOD,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEGATIVE,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEUTRAL,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description:
              "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
          rate: CommentRate.GOOD,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEGATIVE,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEUTRAL,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description:
              "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
          rate: CommentRate.GOOD,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEGATIVE,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEUTRAL,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description:
              "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
          rate: CommentRate.GOOD,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEGATIVE,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEUTRAL,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description:
              "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
          rate: CommentRate.GOOD,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEGATIVE,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEUTRAL,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description:
              "descridsfgdsfgsdfpgjsdfiogjdfiogjsdfogkjsdfokgjdfskogjsdfkogjsdfkgjdsfkgjskdlfgjsdgkldsfogjsdfogijsdfokgjsdfkogjsdfkogjsdfkption",
          rate: CommentRate.GOOD,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
      Comment(
          userId: "1",
          description: "description",
          rate: CommentRate.NEGATIVE,
          approved: true,
          User: User(username: "username", icon: "icon"),
          shopID: "123213312123312312312"),
    ];
  }

  AppBar _appbar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text("Shop - $title"),
    );
  }

  Widget _shopRating() {
    return Container(
      height: 80.0,
      alignment: Alignment.center,
      child: const Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "4.0",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
              ),
              VerticalDivider(
                width: 30.0,
                thickness: 0,
              ),
              Column(
                children: [
                  Text(
                    "20",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "negative",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              ),
              VerticalDivider(
                width: 30.0,
                thickness: 0.3,
              ),
              Column(
                children: [
                  Text("20", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    "neutral",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              ),
              VerticalDivider(
                width: 30.0,
                thickness: 0.3,
              ),
              Column(
                children: [
                  Text("20", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    "good",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _shopDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 15.0),
          color: Colors.black12,
          child: (_shop.icon == null || _shop.icon == "")
              ? Icon(
                  Icons.store_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 26,
                )
              : Image.network(
                  _shop.icon!,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            _shop.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            _shop.address,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
          ),
        )
      ]),
    );
  }

  Widget _shopComment() {
    return ListView.builder(
      itemCount: _comment.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CommentItem(comment: _comment[index]);
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbar(_shop.name),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          height: 60.0,
          child: FilledButton(
              onPressed: () => context.go("/shop/${widget.id}/request"),
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
              ))),
      body: RWDLayout(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [_shopDetail(), _shopRating(), _shopComment()],
        ),
      ),
    );
  }
}
