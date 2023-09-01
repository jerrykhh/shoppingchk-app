import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/models/ModelProvider.dart';

class ShopItem extends StatelessWidget {
  final Shop shop;
  const ShopItem({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => context.go("/shop/${shop.id}"),
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(children: [
            Center(
              child: Container(
                width: 60,
                height: 60,
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
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                shop.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                shop.address,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ]),
          ]),
        ));
  }
}
