import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/pages/request/abs_request.dart';
import 'package:path/path.dart' as p;
import 'package:shoppingchk/tools/localization.dart';

class CommentRequestPage extends RequestPage {
  final String shopID;
  const CommentRequestPage({super.key, required this.shopID});

  void handleCommentCreate(
      {required String userId,
      title,
      description,
      List<XFile> images = const [],
      CommentRate rate = CommentRate.NEUTRAL}) async {
    List<String> imagePaths = [];

    if (images.isNotEmpty) {
      List<String?> uploadedImagePaths =
          await Future.wait(images.map((element) async {
        try {
          final uuid = UUID.getUUID();
          final fileExtension = p.extension(element.path);
          final key = "$shopID/$uuid$fileExtension";
          final result = await Amplify.Storage.uploadFile(
                  localFile: AWSFile.fromPath(element.path), key: key)
              .result;
          return result.uploadedItem.key;
        } on StorageException catch (e) {
          safePrint("Error uploading file: $e");
        }
        return null;
      }));

      imagePaths = uploadedImagePaths.whereType<String>().toList();
    }

    Amplify.DataStore.save(Comment(
        userId: userId,
        shopID: shopID,
        rate: rate,
        description: description,
        images: imagePaths,
        approved: false));
  }

  @override
  RequestPageState<CommentRequestPage> createState() =>
      _CommentRequestPageState();
}

class _CommentRequestPageState extends RequestPageState<CommentRequestPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Localization _localization = Localization.instance;
  final ImagePicker _imagePicker = ImagePicker();
  CommentRate _rate = CommentRate.NEUTRAL;

  List<XFile> _imageFileList = [];
  // CommentRate rate;

  Future pickImage() async {
    try {
      final images = await _imagePicker.pickMultiImage(imageQuality: 60);
      if (images.isEmpty) return;
      setState(() => _imageFileList = images);
    } on PlatformException catch (e) {
      safePrint("pick image failed $e");
    }
  }

  void _changeCommentRate(CommentRate rate) {
    setState(() => _rate = rate);
  }

  void removeIdxImageFile(int index) {
    var newImageFileList = _imageFileList;
    newImageFileList.removeAt(index);
    setState(() => _imageFileList = newImageFileList);
  }

  @override
  Widget build(BuildContext context) {
    return super.structure(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Text(_localization.get(context).commentRequestTitleDescription),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () => _changeCommentRate(CommentRate.NEGATIVE),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: (_rate == CommentRate.NEGATIVE)
                            ? Colors.black
                            : Colors.white,
                        border: const Border(
                            top: BorderSide(
                              width: 2.0,
                            ),
                            left: BorderSide(
                              width: 2.0,
                            ),
                            right: BorderSide(width: 1.0),
                            bottom: BorderSide(
                              width: 2.0,
                            )),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                        ),
                      ),
                      child: Text(
                        _localization.get(context).commentRequestNegative,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: (_rate == CommentRate.NEGATIVE)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () => _changeCommentRate(CommentRate.NEUTRAL),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: (_rate == CommentRate.NEUTRAL)
                          ? Colors.black
                          : Colors.white,
                      border: const Border(
                          top: BorderSide(width: 2.0, color: Colors.black),
                          left: BorderSide(width: 0, color: Colors.black),
                          right: BorderSide(width: 0),
                          bottom: BorderSide(width: 2.0, color: Colors.black)),
                    ),
                    child: Text(
                      _localization.get(context).commentRequestNeutral,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: (_rate == CommentRate.NEUTRAL)
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () => _changeCommentRate(CommentRate.GOOD),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: (_rate == CommentRate.GOOD)
                          ? Colors.black
                          : Colors.white,
                      border: const Border(
                          top: BorderSide(width: 2.0),
                          left: BorderSide(width: 1.0),
                          right: BorderSide(width: 2.0),
                          bottom: BorderSide(width: 2.0)),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                    ),
                    child: Text(
                      _localization.get(context).commentRequestGoodRate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (_rate == CommentRate.GOOD)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _titleController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: _localization
                  .get(context)
                  .commentRequestCommentTitleTextFieldLabel,
              labelText: _localization
                  .get(context)
                  .commentRequestCommentTitleTextFieldLabel,
            )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          maxLines: 4,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          controller: _descriptionController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: _localization
                  .get(context)
                  .commentRequestCommentDescriptionTextFieldLable,
              alignLabelWithHint: true),
          validator: (value) {
            return value!.trim().isNotEmpty
                ? null
                : _localization
                    .get(context)
                    .commentRequestCommentDescriptionTextFieldErrorMes;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          onPressed: () => pickImage(),
          child: Text(
            _localization.get(context).commentRequestCommentImagePickerLabel,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      if (_imageFileList.isNotEmpty) ...[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: _imageFileList.length,

                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.file(
                          File(_imageFileList[index].path),
                          width: 105,
                          height: 105,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                removeIdxImageFile(index);
                              },
                            ),
                          ),
                        )
                      ],
                    )),
              )),
        )
      ],
      Padding(
          padding: const EdgeInsets.only(top: 45),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if ((formKey.currentState as FormState).validate()) {
                widget.handleCommentCreate(
                    userId: userId,
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    images: _imageFileList,
                    rate: _rate);
              }
            },
          )),
    ]);
  }
}
