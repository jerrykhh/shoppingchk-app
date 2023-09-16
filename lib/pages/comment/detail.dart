import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/models/ModelProvider.dart';

class CommentDetailPage extends StatefulWidget {
  final String id;
  const CommentDetailPage({super.key, required this.id});

  @override
  State<CommentDetailPage> createState() => commentDetailPageState();
}

class commentDetailPageState extends State<CommentDetailPage> {
  List<String> images = [];

  Future<List<String>> convertS3ImagePath(List<String>? imagePath) async {
    if (imagePath!.isNotEmpty) {
      final s3ImgKey = await Future.wait(imagePath!.map((e) async {
        try {
          final result = await Amplify.Storage.getUrl(
            key: e,
          ).result;
          return result.url.toString();
        } on StorageException catch (e) {
          safePrint('Could not get a downloadable URL: ${e.message}');
        }
      }));

      return s3ImgKey.whereType<String>().toList();
    }
    return [];
  }

  Future<Comment> fetchComment() async {
    Comment comment = (await Amplify.DataStore.query(Comment.classType,
            where: Comment.ID.eq(widget.id)))
        .first;

    return comment;
  }

  @override
  void initState() {
    super.initState();

    // comment = Comment(
    //     userId: "userId",
    //     approved: true,
    //     rate: CommentRate.NEGATIVE,
    //     description:
    //         "descriptasdfasdkfjasdklfjasdklfjkl asdflkjasd;klf jasdflk asdklfjasdl k jasldkf jasdklfjaskldfjasldkfj asdf aklsdjfasdkl fjalsdk jsdklaf jasdkl fjasdklf jsdlakfj asdkl jaklsdf jasdklf jasdlkf jsdfklion",
    //     shopID: "shopID",
    //     images: [
    //       "https://i0.wp.com/www.wcipp.org.au/wp-content/uploads/2022/12/test-image-Not-seen-on-Bungalook-Web-Page-used-for-testing-Image-related-stuff.jpg?fit=1920%2C1080&ssl=1",
    //       "https://www.polyu.edu.hk/-/media/department/home/setting/default_image_2x.jpg?bc=ffffff&h=630&w=1200&hash=8AE8BD3002A7BA999BA975E67C49A716",
    //       "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource112/v4/e6/aa/57/e6aa57d5-e500-1f75-d892-177f182ad2fc/5312bf0a-a8ab-4949-a9d0-6f3d92379e12_Simulator_Screen_Shot_-_iPhone_13_Pro_Max_-_2022-07-14_at_12.13.27.png/300x0w.jpg"
    //     ],
    //     User: User(username: "username", icon: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comment"),
        ),
        body: FutureBuilder(
          future: fetchComment(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Comment comment = snapshot.data!;

              return RWDLayout(
                  child: ListView(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 15.0),
                              decoration: BoxDecoration(
                                color: (comment.rate == CommentRate.NEGATIVE)
                                    ? Colors.black87
                                    : (comment.rate == CommentRate.NEUTRAL)
                                        ? Colors.white30
                                        : Colors.black12,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                  comment.rate
                                      .toString()
                                      .replaceAll("CommentRate.", ""),
                                  style: TextStyle(
                                    color: (comment.rate == CommentRate.NEUTRAL)
                                        ? Colors.black
                                        : Colors.white,
                                  ))),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: Text(comment.title ?? "",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Flex(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    margin: const EdgeInsets.only(right: 20.0),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(60.0)),
                                    child: const Icon(Icons.person_2_rounded),
                                    // child: (comment.Customer!.icon.isEmpty ||
                                    //         comment.Customer!.icon == "")
                                    //     ? const Icon(Icons.person_2_rounded)
                                    //     : Image.network(
                                    //         comment.Customer!.icon,
                                    //         fit: BoxFit.cover,
                                    //       ),
                                  )),
                              Flexible(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Text(
                                              //   comment.Customer!.username,
                                              //   style: const TextStyle(
                                              //       fontSize: 14,
                                              //       fontWeight: FontWeight.bold),
                                              // ),
                                              Text(
                                                DateFormat('yyyy-MM-dd kk:mm')
                                                    .format(comment.createdAt!
                                                        .getDateTimeInUtc()
                                                        .toLocal()),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              )
                                            ]),
                                      ),
                                      Text(
                                        comment.description,
                                        softWrap: true,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 30.0),
                              child: FutureBuilder(
                                future: convertS3ImagePath(comment.images),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final imgs = snapshot.data;
                                    return Column(
                                      children: imgs!.map((e) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Image.network(
                                              e,
                                              fit: BoxFit.cover,
                                            ));
                                      }).toList(),
                                    );
                                  }
                                  return Container(
                                      alignment: Alignment.center,
                                      child: const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(),
                                      ));
                                },
                              )),
                        ],
                      )),
                ],
              ));
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}
