import 'package:crud_api_flutterr/controller/product_controller.dart';
import 'package:crud_api_flutterr/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key});
  ProductController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  onSave() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final product = controller.product;
      var result = product.id == 0
          ? await controller.insertProduct()
          : await controller.updateProduct(product.id);
      if (result) {
        await controller.refreshProduct();
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'ID'),
                      enabled: false,
                      initialValue: product.id.toString(),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      initialValue: product.title,
                      onSaved: (newValue) {
                        product.title = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      initialValue: product.description,
                      maxLines: 4,
                      onSaved: (newValue) {
                        product.description = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Price'),
                      initialValue: '${product.price}',
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        product.price = int.tryParse(newValue!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Discount'),
                      initialValue: '${product.discountPercentage}',
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        product.discountPercentage =
                            double.tryParse(newValue!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Rating'),
                      initialValue: '${product.rating}',
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        product.rating = double.tryParse(newValue!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Stock'),
                      initialValue: '${product.stock}',
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        product.stock = int.tryParse(newValue!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Brand'),
                      initialValue: product.brand,
                      onSaved: (newValue) {
                        product.brand = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Category'),
                      initialValue: product.category,
                      onSaved: (newValue) {
                        product.category = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Tumbnail'),
                      initialValue: product.thumbnail,
                      onSaved: (newValue) {
                        product.thumbnail = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Images'),
                      initialValue: product.images,
                      onSaved: (newValue) {
                        product.images = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await onSave();
                        },
                        child: Text('Save')),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {},
                        child: Text('Delete')),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
