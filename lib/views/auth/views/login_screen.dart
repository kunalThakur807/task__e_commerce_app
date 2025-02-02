import 'package:app_task/utils/constants/constants.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:app_task/utils/services/credentials_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? Row(
                children: [
                  Expanded(
                      flex: 1, child: LoginForm(formKey: _formKey, size: size)),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      height: size.height,
                      width: size.width,
                      "assets/images/login_dark.png",
                      fit: BoxFit.fill,
                      color:
                          Colors.black.withOpacity(0.5), // Apply black overlay
                      colorBlendMode:
                          BlendMode.darken, // Blend mode to darken the image
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Image.asset(
                    "assets/images/login_dark.png",
                    fit: BoxFit.cover,
                  ),
                  LoginForm(formKey: _formKey, size: size)
                ],
              ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.size,
  });

  final GlobalKey<FormState> formKey;
  final Size size;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: defaultPadding / 2),
          const Text(
            "Log in with your data that you entered during your registration.",
          ),
          const SizedBox(height: defaultPadding),
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  onSaved: (email) {
                    // Email
                  },
                  validator: emaildValidator.call,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.75),
                      child: SvgPicture.asset(
                        "assets/icons/Message.svg",
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.3),
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: password,
                  onSaved: (pass) {
                    // Password
                  },
                  validator: passwordValidator.call,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.75),
                      child: SvgPicture.asset(
                        "assets/icons/Lock.svg",
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.3),
                            BlendMode.srcIn),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: TextButton(
              child: const Text("Forgot password"),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: widget.size.height > 700
                ? widget.size.height * 0.1
                : defaultPadding,
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                CredentialsStorage.saveCredentials(email.text, password.text);
              }
            },
            child: const Text("Log in"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {},
                child: const Text("Sign up"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
