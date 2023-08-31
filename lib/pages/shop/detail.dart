import 'package:flutter/material.dart';
import 'package:shoppingchk/data/shop/query.dart';
import 'package:shoppingchk/models/ModelProvider.dart';

class ShopDetailPage extends StatefulWidget {
  final String id;
  const ShopDetailPage({super.key, required this.id});

  @override
  State<ShopDetailPage> createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  late Future<Shop> _shop;

  @override
  void initState() {
    super.initState();
    _shop = queryShop(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _shop,
            builder: (BuildContext context, AsyncSnapshot<Shop> snapshot) {
              final item = snapshot.data;
              return Text(item!.name);
            }));
  }
}
