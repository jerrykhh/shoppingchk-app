import 'package:shoppingchk/pages/request/comment_request.dart';
import 'package:shoppingchk/pages/request/shop_request.dart';

Map<String, Function> reqFormRegister = {
  '1': () => const ShopRequestPage(),
  '2': (String shopId) => CommentRequestPage(
        shopID: shopId,
      )
};
