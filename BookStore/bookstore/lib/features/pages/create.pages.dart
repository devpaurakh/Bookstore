// ignore_for_file: use_build_context_synchronously

import 'package:bookstore/features/service/addProduct.provider.dart';
import 'package:bookstore/features/service/productGet.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                    hintText: 'Enter Product Name',
                  ),
                  validator: (value) {
                    final nameRegExp = RegExp(r'^[a-zA-Z\s\-]+$');
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (!nameRegExp.hasMatch(value)) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: productPriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Price',
                    hintText: 'Enter Product Price',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Product Price';
                    } else if (RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                        .hasMatch(value)) {
                      return 'Enter a Valid Price';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ImageUrl',
                    hintText: 'Add Image URL',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Add Image URL';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                Consumer<AddProductProvider>(
                    builder: (context, addProduct, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                    ),
                    onPressed: () {
                      // Add product
                      if (_formKey.currentState!.validate()) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Are you sure you want to add this product?',
                          confirmBtnText: 'Add +',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () async {
                            await addProduct.addProduct(
                              productNameController.text.trim(),
                              productPriceController.text.trim(),
                              imageUrlController.text.trim(),
                            );
                            productNameController.clear();
                            productPriceController.clear();
                            imageUrlController.clear();

                            await Provider.of<GetAppProductProvider>(context,
                                    listen: false)
                                .getProduct();

                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Please fill all fields',
                          confirmBtnText: 'Ok',
                          confirmBtnColor: Colors.red,
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    child: addProduct.isLoading == true
                        ? const SizedBox(
                            height: 20,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ))
                        : const Text('Add Product'),
                  );
                })
              ],
            )),
      ),
    );
  }
}
