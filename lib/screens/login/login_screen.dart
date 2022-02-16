import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth_test/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('loginscreen');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          const SizedBox(
            height: 80,
            child: Text('Login', style: TextStyle(fontSize: 28)),
          ),
          SizedBox(
            width: 320,
            child: TextFormField(
              validator: (value) =>
                  EmailValidator.validate(value!) ? null : 'Enter valid Email',
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                contentPadding: EdgeInsets.all(10),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 320,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          SizedBox(
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      context
                          .read<UserProvider>()
                          .forgotPassword(emailController.text);
                    },
                    child: const Text('Forgot Password?'))
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UserProvider>().loginUser(
                    emailController.value.text, passwordController.value.text);
              }
            },
            child: const Text('Login'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text('Dont have account?'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('Sign Up')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
