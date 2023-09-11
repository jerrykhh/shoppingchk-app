import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingchk/pages/request/abs_request.dart';

class CommentRequestPage extends RequestPage {
  const CommentRequestPage({super.key});
  @override
  State<RequestPage> createState() => _CommentRequestPageState();
}

class _CommentRequestPageState extends RequestPageState {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _imageFileList = [];

  Future pickImage() async {
    try {
      final images = await _imagePicker.pickMultiImage(imageQuality: 60);
      if (images.isEmpty) return;
      setState(() => _imageFileList = images);
    } on PlatformException catch (e) {
      safePrint("pick image failed $e");
    }
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
        child:
            const Text("Please let me know whats your comment about the shop"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: "Title",
              labelText: "Title",
            )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          maxLines: 4,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          controller: _descriptionController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: "Description/Remark (optional)",
              alignLabelWithHint: true),
          validator: (value) {
            return value!.trim().isNotEmpty
                ? null
                : "Description Cannot be Empty";
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
          child: const Text(
            "Pick a picture (Optional)",
            style: TextStyle(color: Colors.black),
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
              if ((formKey.currentState as FormState).validate()) {}
            },
          )),
    ]);
  }
}
