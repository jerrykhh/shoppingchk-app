import 'package:shoppingchk/data/query.dart';
import 'package:shoppingchk/models/Shop.dart';

Future<List<Shop>> queryAllShops({int page = 0, int limit = 30}) async {
  return queryAll<Shop>();
}

Future<Shop> queryShop(String id) async {
  return queryById<Shop>(id);
}
