import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/config/constant/height_spacer.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/features/auth/presentation/view/register_view.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool _obsecuretext = true;

  final _gap = HeightSpacer(size: 10.h);

  final key = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
          gradient: LinearGradient(
              colors: [Color(kLight.value), Color(kLightGrey.value)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 330,
                        width: 430,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            image: DecorationImage(
                              image: AssetImage('assets/images/sigin.png'),
                            )),
                      ),
                    ),
                    _gap,
                    ReusableText(
                      text: 'Welcome!',
                      fontSize: 40,
                      color: Colors.black,
                    ),
                    _gap,
                    ReusableText(
                      text: 'Fill the below fields for Sign In',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          labelText: 'Email',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter you email';
                        } else if (!value.contains('@')) {
                          return '@ is missing';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: _obsecuretext,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecuretext = !_obsecuretext;
                              });
                            },
                            child: Icon(
                              _obsecuretext
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your password';
                        } else if (value.length < 6) {
                          return 'Passwors must contai six letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(kDark.value),
                            minimumSize: Size(200, 60)),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RegisterView()));
                            ref
                                .read(authViewModelProvider.notifier)
                                .signInFreelancer(context, emailcontroller.text,
                                    passwordcontroller.text);
                          }
                        },
                        child: ReusableText(
                          color: Color(kLight.value),
                          fontSize: 20,
                          text: 'Sign In',
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterView()));
                        },
                        child: ReusableText(
                          text: "Don't have an account? Sign Up",
                          fontSize: 15,
                          color: Color(kDark.value),
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
