import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/auth_controller.dart';
import 'package:mikan/view/widgets/bottom_nav_bar.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController _registerController = Get.put(AuthController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              return ElevatedButton(
                  onPressed: _registerController.isLoading.value
                      ? null
                      : () {
                          _registerController.registerAppwrite(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                          );
                        },
                  child: _registerController.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Register'));
            })
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}