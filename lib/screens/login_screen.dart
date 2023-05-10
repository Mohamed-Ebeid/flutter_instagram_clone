import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utiles/colors.dart';
import 'package:instagram_flutter/utiles/global_variables.dart';
import 'package:instagram_flutter/utiles/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'Success!') {
      //print('done');
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void goToSignUp() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          SvgPicture.asset(
            'assets/insta_logo.svg',
            color: Colors.blueGrey,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Enter Your Email:',
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 40,
          ),
          TextFieldInput(
            textEditingController: _passwordController,
            hintText: 'Enter Your Password:',
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: loginUser,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                color: blueColor,
              ),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : const Text('Log in'),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text("Don't have an account?"),
              ),
              GestureDetector(
                onTap: goToSignUp,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ]),
      )),
    );
  }
}
