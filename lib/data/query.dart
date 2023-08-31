import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shoppingchk/models/Shop.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;

Future<List<T>> queryAll<T>({int page = 0, int limit = 30}) async {
  try {
    final items = await Amplify.DataStore.query(T as ModelType,
        pagination: QueryPagination(page: page, limit: limit));
    return items as List<T>;
  } on DataStoreException catch (e) {
    safePrint('Something went wrong querying ${T.toString()}: ${e.message}');
    rethrow;
  }
}

Future<T> queryById<T>(String id) async {
  try {
    final items = await Amplify.DataStore.query(T as ModelType,
        where: QueryPredicateOperation('id', EqualQueryOperator(id)));
    return items.first as T;
  } on DataStoreException catch (e) {
    safePrint('Something went wrong querying ${T.toString()}: ${e.message}');
    rethrow;
  }
}
