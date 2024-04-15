import 'package:classwork/controller/counter_controller.dart';
import 'package:classwork/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  @override
  void initState() {
    //checkIfUserIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    loginController.checkIfUserIsLoggedIn(context);
    Get.put(CounterController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: loginController.formKeyy,
        child: Column(
          children: [
            TextFormField(
              controller: loginController.usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your username'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: loginController.passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.2,
                  child: Obx(() {
                    return Checkbox(
                      value: loginController.isChecked.value,
                      onChanged: (newValue) {
                        print('New Value $newValue');
                        if (newValue != null) {
                          loginController.isChecked.value = newValue;
                        }
                      },
                    );
                  }),
                ),
                FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text('Agree to all conditions of the app?')),
              ],
            ),
            Wrap(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: () => loginController.handleLogin(context),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.03,
                ),
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Reset'),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.03,
                ),
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Text('Signup'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
