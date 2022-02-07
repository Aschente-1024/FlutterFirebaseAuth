import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  contentPadding: EdgeInsets.all(10)),
              onChanged: (email) {
                print(emailController.value);
              },
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Email: ${emailController.value.text} Password: ${passwordController.value.text}'),
                  ),
                );
              }
            },
            child: Text('Login'),
          )
        ],
      ),
    );
  }
}
