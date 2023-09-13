import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/pages/request/abs_request.dart';

class ShopRequestPage extends RequestPage {
  const ShopRequestPage({super.key});

  @override
  State<RequestPage> createState() => _ShopRequestState();
}

class _ShopRequestState extends RequestPageState {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _handleShopCreateRequest() async {
    Amplify.DataStore.save(Request(
        userId: userId,
        description: _descriptionController.text.trim(),
        type: RequestType.NEWSHOP));

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return super.structure(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: const Text(
            "This form for request new Shop, please provide details about the shop."),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: "Shop name",
              labelText: "Shop name",
            ),
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? null
                  : "Shop name Cannot be Empty";
            }),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _addressController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: "Please give a detail address",
              labelText: "Address",
            ),
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? null
                  : "Address Cannot be Empty";
            }),
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
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              if ((formKey.currentState as FormState).validate()) {
                _handleShopCreateRequest();
              }
            },
          )),
    ]);
  }
}
