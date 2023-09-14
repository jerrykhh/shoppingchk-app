import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/pages/request/abs_request.dart';
import 'package:shoppingchk/tools/localization.dart';

class ShopRequestPage extends RequestPage {
  const ShopRequestPage({super.key});

  @override
  State<RequestPage> createState() => _ShopRequestState();
}

class _ShopRequestState extends RequestPageState {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Localization localization = Localization.instance;

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
        child: Text(localization.get(context).shopRequestTitle),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _nameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: localization.get(context).shopRequestShopTextFieldLabel,
              labelText:
                  localization.get(context).shopRequestShopTextFieldLabel,
            ),
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? null
                  : localization.get(context).shopRequestShopTextFieldErrorMes;
            }),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _addressController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText:
                  localization.get(context).shopRequestShopAddressTextFieldHint,
              labelText: localization
                  .get(context)
                  .shopRequestShopAddressTextFieldLabel,
            ),
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? null
                  : localization
                      .get(context)
                      .shopRequestShopAddressTextFieldErrorMes;
            }),
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
              labelText: localization
                  .get(context)
                  .shopRequestShopDescriptionTextFieldLabel,
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
            child: Text(
              localization.get(context).btnSubmit,
              style: const TextStyle(fontWeight: FontWeight.w500),
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
