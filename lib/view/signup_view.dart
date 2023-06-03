import 'package:flutter/material.dart';
import 'package:invoice/res/components/round_button.dart';
import 'package:invoice/utils/routes/routes_name.dart';
import 'package:invoice/utils/utils.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode(); // shift to next field by enter
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)
                ),
                onFieldSubmitted: (val) {
                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_open_rounded),
                          suffixIcon:InkWell(
                            onTap: (){
                              _obsecurePassword.value = !_obsecurePassword.value;
                            },
                            child: Icon(
                                _obsecurePassword.value ? Icons.visibility_off_outlined : Icons.visibility
                            ),
                          )
                      ),
                    );
                  }
              ),
              SizedBox(height: height * .085,),
              RoundButton(
                title: 'Signup',
                loading: authViewMode.loading,
                onPress: (){
                  if(_emailController.text.isEmpty){
                    Utils.snakBar('Please enter email', context);
                  } else if(_passwordController.text.isEmpty) {
                    Utils.snakBar('Please enter password', context);
                  } else {
                    print("hit api");
                    Map data = {
                      'email':_emailController.text.toString(),
                      'password': _passwordController.text.toString()
                    };
                    authViewMode.signupApi(data, context);
                  }
                },
              ),
              SizedBox(height: height * .02,),
               InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text("Already have an account ? Login"),
              ),
            ],
          ),
        )
      // Center(
      //   child: InkWell(
      //     onTap: (){
      //       Utils.toastMessage('No internet Connections');
      //       Utils.flushBarErrorMessage('flush error', context);
      //       Utils.snakBar('snack message', context);
      //         Navigator.pushNamed(context, RoutesName.home); // current nav
      //         // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())); // old nav
      //     },
      //     child: Text('Click'),
      //   ),
      // )
    );
  }
}
