import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth_test/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: const Center(
        child: SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('signupscreen');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          const SizedBox(
            height: 80,
            child: Text('Sign Up', style: TextStyle(fontSize: 28)),
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
                  contentPadding: EdgeInsets.all(10)),
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
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 320,
            child: TextFormField(
              controller: passwordConfirmController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Confirm Password',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UserProvider>().createNewUser(
                    emailController.text, passwordController.text);
                Navigator.pushReplacementNamed(context, '/');
              }
            },
            child: const Text('Sign up'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text('Already have account?'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Log In')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
