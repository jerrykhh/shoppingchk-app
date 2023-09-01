import 'package:flutter/material.dart';
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
              hintText: "Address",
              labelText: "Please give a detail address",
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
              if ((formKey.currentState as FormState).validate()) {}
            },
          )),
    ]);
  }
}
