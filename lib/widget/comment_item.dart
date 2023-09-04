import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/models/Comment.dart';
import 'package:shoppingchk/models/CommentRate.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => context.go("/shop/${comment.shopID}/comment/${comment.id}",
            extra: comment),
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Flex(direction: Axis.horizontal, children: [
            Center(
              child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.black12,
                  child: Icon(
                    Icons.person_2_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 26,
                  )),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 25.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.Customer!.username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        comment.description,
                        style: const TextStyle(
                            color: Colors.black38, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: (comment.rate == CommentRate.NEGATIVE)
                      ? Colors.black87
                      : (comment.rate == CommentRate.NEUTRAL)
                          ? Colors.white30
                          : Colors.black12,
                ),
                child: Text(
                  comment.rate.toString().replaceAll("CommentRate.", ""),
                  style: TextStyle(
                      color: (comment.rate == CommentRate.NEUTRAL)
                          ? Colors.black
                          : Colors.white,
                      fontSize: 10),
                ),
              ),
            )
          ]),
        ));
  }
}
