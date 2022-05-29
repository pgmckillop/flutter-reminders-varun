import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback toggleView;

  const SignUpScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text('Sign up'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
            ),
            Text(
              'Yet Another ToDo List',
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration:
                          const InputDecoration(hintText: 'Enter Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val == null || !val.contains('@')
                          ? 'Enter an email address'
                          : null,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(hintText: 'Enter Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password of at least 6 characters'
                          : null,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Submit form');
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
