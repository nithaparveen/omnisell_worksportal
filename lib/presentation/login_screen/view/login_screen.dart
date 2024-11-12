import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/login_screen/controller/login_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Omnisell - WorksPortal",
          style: GLTextStyles.cabinStyle(size: 22),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: size.width * 0.025,
                    child: Image.asset("assets/logo text.png"),
                  ),
                ),
                SizedBox(height: size.width * .075),
                Text(
                  "Email Address",
                  style: GLTextStyles.interStyle(size: 14, weight: FontWeight.w500),
                ),
                SizedBox(height: size.width * .02),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail, size: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xff1A3447)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.width * .03),
                Text(
                  "Password",
                  style: GLTextStyles.interStyle(size: 14, weight: FontWeight.w500),
                ),
                SizedBox(height: size.width * .02),
                Consumer<LoginController>(
                  builder: (context, controller, _) {
                    return TextFormField(
                      obscureText: controller.visibility,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            controller.onPressed();
                          },
                          icon: Icon(
                            controller.visibility ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xff1A3447)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: size.width * .04),
                SizedBox(
                  height: size.height * 0.085,
                  width: size.width * 0.95,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    color: ColorTheme.lightBlue,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<LoginController>(context, listen: false)
                            .onLogin(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          context,
                        );
                      }
                    },
                    child: Text(
                      "Login",
                      style: GLTextStyles.cabinStyle(
                        color: ColorTheme.white,
                        size: 20,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}