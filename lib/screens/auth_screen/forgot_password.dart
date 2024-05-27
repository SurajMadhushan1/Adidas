import 'package:adidas/components/custom_buttons/custom_button1.dart';
import 'package:adidas/components/custom_text/custom_poppins_text.dart';
import 'package:adidas/components/custom_text_field/custom_textfield1.dart';
import 'package:adidas/providers/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<SignInProvider>(builder: (context, value, child) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      BackButton(),
                      CustomPoppinsText(
                        text: "Reset Your Password",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const CustomPoppinsText(
                    text: "Insert your email and get password reset email.",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField1(
                      label: "Email",
                      icon: Icons.email,
                      controller: value.resetEmail),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton1(
                      size: size,
                      text: "Send Reset Email",
                      bgColor: Colors.orange.shade800,
                      ontap: () {
                        value.sendResetEmail();
                      })
                ]);
          }),
        ),
      ),
    );
  }
}
