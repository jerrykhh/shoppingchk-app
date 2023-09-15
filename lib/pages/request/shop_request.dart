import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/pages/request/abs_request.dart';
import 'package:shoppingchk/tools/localization.dart';
import 'package:shoppingchk/widget/form_component.dart';

class ShopRequestPage extends RequestPage {
  const ShopRequestPage({super.key});

  @override
  State<RequestPage> createState() => _ShopRequestState();
}

class _ShopRequestState extends RequestPageState {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _shopCategoryTypeController =
      TextEditingController();
  final Localization localization = Localization.instance;

  void _handleShopCreateRequest() async {
    try {
      final shopName = _nameController.text.trim();
      final shopType = _shopCategoryTypeController.text;
      final descrpition = _descriptionController.text.trim();
      final userId = (await Amplify.Auth.getCurrentUser()).userId;

      final shopRequest = Request(
          userId: userId,
          description: jsonEncode({
            "shopName": shopName,
            "shopType": shopType,
            "descrpiton": descrpition
          }),
          type: RequestType.NEWSHOP);
      await Amplify.DataStore.save(shopRequest);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        formState = RequestFormState.finished;
      });

      await Future.delayed(const Duration(seconds: 3), () => context.pop());
    } on DataStoreException catch (e) {
      safePrint(e);
      setState(() {
        formState = RequestFormState.already;
      });
    }
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
        // child: StyledTextFromFiled(
        //     controller: _nameController,
        //     hintText: localization.get(context).shopRequestShopTextFieldLabel,
        //     labelText:
        //         localization.get(context).shopRequestShopTextFieldLabel,
        //     validator: (value) {
        //       return value!.trim().isNotEmpty
        //           ? null
        //           : localization
        //               .get(context)
        //               .shopRequestShopTextFieldErrorMes;
        //     })
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
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: DropdownMenu<String>(
            label: const Text("Gender"),
            controller: _shopCategoryTypeController,
            initialSelection: StoreCategoryType.values.first.name,
            dropdownMenuEntries: StoreCategoryType.values
                .map((e) => e.name)
                .map<DropdownMenuEntry<String>>((String value) =>
                    DropdownMenuEntry<String>(
                        label: value.replaceAll("_", " "),
                        value: value.replaceAll("_", " ")))
                .toList(),
          )),
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
          padding: const EdgeInsets.only(top: 50, bottom: 80),
          child: SubmitButton(
            state: formState,
            onPressed: () {
              if ((formKey.currentState as FormState).validate()) {
                setState(() {
                  formState = RequestFormState.processing;
                });
                _handleShopCreateRequest();
              }
            },
          )),
    ]);
  }
}
