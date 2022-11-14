import 'package:buzz/constants.dart';
import 'package:buzz/screens/auth/Signup.dart';
import 'package:buzz/theme/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../../controllers/Authentication.dart';
import '../../../theme/decoration.dart';
import '../../../widgets/textFieldInput.dart';

class signin extends StatelessWidget {
  signin({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Image(
                  image: AssetImage('assets/login.jpg'),
                ),
              ),
              Obx(() {
                return Container(
                  decoration: Decor1LoginPage,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          "Login Account",
                          style: AuthText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome back to Buzz...",
                          style: NormalTextGrey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: email,
                          hintText: "Enter Your Emai",
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: password,
                          hintText: "Enter Your Password",
                          textInputType: TextInputType.visiblePassword,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        authController.isDealer.value
                            ? TextFieldInput(
                                textEditingController: dealerId,
                                hintText: "Enter Dealer Id",
                                textInputType: TextInputType.text,
                              )
                            : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: Decor1LoginPageButton,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (authController.isDealer.value == true) {
                                    if (authController.dealerIdForLogin ==
                                        dealerId.toString()) {
                                      authController.login(email.text.trim(),
                                          password.text.trim());
                                    }
                                    if (dealerId.text.isEmpty &&
                                        email.text.isNotEmpty &&
                                        password.text.isNotEmpty) {
                                      Get.snackbar(
                                        "Enter Dealer ID ",
                                        "Enter Your Unique Dealer Id",
                                        borderRadius: 10,
                                        colorText: Colors.white,
                                        backgroundColor:
                                            Color.fromARGB(255, 76, 82, 165),
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 30, top: 30),
                                      );
                                    }
                                  }
                                  if (email.text.isEmpty &&
                                      password.text.isNotEmpty) {
                                    Get.snackbar(
                                      "Enter Email Id ",
                                      "Enter The Email Id Associated With Your Account",
                                      colorText: Colors.white,
                                      borderRadius: 10,
                                      backgroundColor:
                                          Color.fromARGB(255, 76, 82, 165),
                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30, top: 30),
                                    );
                                  }
                                  if (password.text.isEmpty &&
                                      email.text.isNotEmpty) {
                                    Get.snackbar(
                                      "Enter Password ",
                                      "Enter The Password Associated With Your Account",
                                      colorText: Colors.white,
                                      borderRadius: 10,
                                      backgroundColor:
                                          Color.fromARGB(255, 76, 82, 165),
                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30, top: 30),
                                    );
                                  }
                                  if (email.text.isEmpty &&
                                      password.text.isEmpty) {
                                    Get.snackbar(
                                      "Enter Email And Password ",
                                      "Enter The Email  And Password Associated With Your Account",
                                      borderRadius: 10,
                                      colorText: Colors.white,
                                      backgroundColor:
                                          Color.fromARGB(255, 76, 82, 165),
                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30, top: 30),
                                    );
                                  } else {
                                    authController.login(email.text.trim(),
                                        password.text.trim());
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: NormalTextWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Row(children: [
                const Expanded(child: Divider()),
                Text(
                  "or Login with",
                  style: NormalTextGrey2,
                ),
                const Expanded(child: Divider()),
              ]),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    authController.SignInWithGoogle();
                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/google.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account ",
                      style: NormalSubTextBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Signup());
                      },
                      child: Text(
                        "Register",
                        style: Register,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (() {
                      authController.isDealer.value = false;
                    }),
                    child: SvgPicture.asset(
                      'assets/consumer.svg',
                      width: 50,
                      height: 50,
                      // color: Colors.purple[400],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      authController.isDealer.value = true;
                    },
                    child: SvgPicture.asset(
                      'assets/seller.svg',
                      width: 50,
                      height: 50,
                      // color: Colors.purple[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
