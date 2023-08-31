import 'package:shoppingchk/data/query.dart';
import 'package:shoppingchk/models/Comment.dart';

Future<Comment> queryComment(String id) {
  return queryById<Comment>(id);
}
