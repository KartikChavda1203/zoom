import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/apiClass/apiClass.dart';
import 'package:zoom/screens/controller/homeController.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  ApiClass apiClass = ApiClass();
  HomeController homeController = Get.put(HomeController());
  var userController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://media.istockphoto.com/id/170611537/vector/marathon-meeting.jpg?s=612x612&w=0&k=20&c=gnGmJOyNHd8QUy_jSJA_uw3EmaWqccEA7Pq9wnhwRFg='),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              color: const Color(0x9A000000),
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 450,
                  width: 300,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          "Meetting Hour",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: userController,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          decoration: InputDecoration(
                            label: const Text(
                              "UserName",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                const BorderSide(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          controller: passController,
                          decoration: InputDecoration(
                            label: const Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              "Forget password?",
                              style: TextStyle(color: Colors.white),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            // Call the login method from HomeController
                            apiClass.login(
                              userController.text,
                              passController.text,
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white)),
                            child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
