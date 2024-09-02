// ignore_for_file: use_build_context_synchronously

import 'package:bookstore/features/pages/create.pages.dart';
import 'package:bookstore/features/service/productDelete.provider.dart';
import 'package:bookstore/features/service/productGet.provider.dart';
import 'package:bookstore/features/service/updateProduct.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAppProductProvider>(context, listen: false).getProduct();
    });
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Available Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.deepPurple,
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<GetAppProductProvider>(
        builder: (context, getAllProduct, child) {
          if (getAllProduct.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (getAllProduct.products.isEmpty) {
            return const Center(
              child: Text(
                'No products available',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: getAllProduct.products.length,
            itemBuilder: (context, index) {
              var product = getAllProduct.products[index];

              return Card(
                color: Colors.white,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      '${product.image}', // Ensure image path is correct
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${product.name}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Rs. ${product.price}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Consumer<UpdateProductProvider>(
                              builder: (contex, update, child) {
                            return _buildElevatedButton(
                                Icons.edit, "Edit", Colors.deepPurple, () {
                              productNameController.text = product.name!;
                              productPriceController.text =
                                  product.price!.toString();
                              imageUrlController.text = product.image!;

                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.custom,
                                  barrierDismissible: true,
                                  title: 'Edit Product',
                                  titleColor: Colors.deepPurple,
                                  confirmBtnText: 'Update',
                                  confirmBtnColor: Colors.deepPurple,
                                  cancelBtnText: 'Cancel',
                                  onConfirmBtnTap: () {
                                    // Add your logic here
                                    if (_formKey.currentState!.validate()) {
                                      update.updateProduct(
                                        productNameController.text.trim(),
                                        productPriceController.text.trim(),
                                        imageUrlController.text.trim(),
                                        product.sId!,
                                      );
                                      getAllProduct.getProduct();
                                      Navigator.pop(context);
                                    }
                                  },
                                  widget: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: productNameController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Product Name',
                                            hintText: 'Enter Product Name',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: productPriceController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Product Price',
                                            hintText: 'Enter Product Price',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: imageUrlController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'ImageUrl',
                                            hintText: 'Add Image URL',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            });
                          }),
                          const SizedBox(width: 10),
                          Consumer<ProductDeleteProvider>(
                              builder: (context, deleteProvider, child) {
                            return _buildElevatedButton(
                                Icons.delete, "Delete", Colors.red, () async {
                              QuickAlert.show(
                                context: context,
                                confirmBtnText: 'Yes',
                                onConfirmBtnTap: () async {
                                  await deleteProvider
                                      .deleteProduct(product.sId!);
                                  Navigator.pop(context);
                                  await getAllProduct.getProduct();
                                },
                                type: QuickAlertType.warning,
                                text: 'Are you sure you want to delete?',
                              );
                            });
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2.5),
                    const Divider(),
                    const SizedBox(height: 2.5),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
        },
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget _buildElevatedButton(IconData icon, String buttonText, Color buttonColor,
    VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      elevation: 0,
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
