import 'package:buzz/constants.dart';
import 'package:buzz/screens/auth/signin.dart';
import 'package:buzz/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/Authentication.dart';
import '../../../theme/Text.dart';
import '../../../theme/decoration.dart';
import '../../../widgets/textFieldInput.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  AuthController controller = Get.put(AuthController());

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
              Container(
                decoration: Decor1SignUpPage,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Obx(() {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Signup Account",
                          style: AuthText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Create your free Buzz... account",
                          style: NormalTextGrey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          textEditingController: name,
                          hintText: "Enter Your Name",
                          textInputType: TextInputType.emailAddress,
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
                          textEditingController: phone,
                          hintText: "Enter your PhoneNumber",
                          textInputType: TextInputType.number,
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
                              child: Builder(builder: (cotext) {
                                return GestureDetector(
                                  onTap: () {
                                    if (authController.isDealer.value == true) {
                                      if (authController.dealerIdForLogin ==
                                          dealerId.toString()) {
                                        authController.register(
                                          email.text,
                                          password.text,
                                        );
                                      }
                                      if (dealerId.text.isEmpty) {
                                        Get.snackbar("Enter Dealer Id", "");
                                      }
                                    } else {
                                      authController.register(
                                        email.text,
                                        password.text,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: NormalTextWhite,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Row(children: <Widget>[
                const Expanded(child: Divider()),
                Text(
                  "or Sign up with",
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
                      "have an account? ",
                      style: NormalSubTextBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          signin(),
                        );
                      },
                      child: Text(
                        "Login",
                        style: Register,
                      ),
                    )
                  ],
                ),
              ),
              //break
              const SizedBox(
                height: 30,
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
            ],
          ),
        ),
      ),
    );
  }
}
