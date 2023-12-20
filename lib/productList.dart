import 'package:crud_api_flutterr/controller/auth_controller.dart';
import 'package:crud_api_flutterr/controller/product_controller.dart';
import 'package:crud_api_flutterr/login.dart';
import 'package:crud_api_flutterr/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});
  ProductController controller = Get.put(ProductController());
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Flutter RestAPI'),
          actions: [
            IconButton(
              onPressed: () {
                authController.Logout();
                Get.off(Login());
              },
              icon: Icon(Icons.logout_outlined),
              iconSize: 30,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            controller.createProduct();
            Get.to(ProductDetail());
          },
          child: Icon(Icons.add),
        ),
        body: Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return InkWell(
                  onTap: () async {
                    await controller.getProduct(product.id);
                    Get.to(ProductDetail());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  product.category,
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                              ),
                              SizedBox(
                                height: 29,
                                child: Text(
                                  product.title,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  '\$ ${product.price}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                        '${product.rating}| Stock ${product.stock}')
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
