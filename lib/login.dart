import 'package:crud_api_flutterr/controller/auth_controller.dart';
import 'package:crud_api_flutterr/productList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final formKey = GlobalKey<FormState>();
  final formData = {"email": "", "password": ""};
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: formKey,
        child: Container(
          height: 450,
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Please Sign to create processing',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                  },
                  onSaved: (newValue) {
                    formData["email"] = newValue!;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                  },
                  onSaved: (newValue) {
                    formData["password"] = newValue!;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            await controller.login(formData);
                            if (controller.isLogedin.value) {
                              Get.off(ProductList());
                            }
                          }
                        },
                        child: Text('LOGIN')))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
