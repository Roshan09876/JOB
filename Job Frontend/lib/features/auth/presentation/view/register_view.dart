import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/config/constant/height_spacer.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';
import 'package:job_finder/features/auth/presentation/view/login_view.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  bool _obsecuretext = true;

  final _key = GlobalKey<FormState>();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();
  final locationController = TextEditingController();
  final phoneNumController = TextEditingController();

  final emailController = TextEditingController();

  final password = TextEditingController();

  final _gap = HeightSpacer(size: 10.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(65),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            image: DecorationImage(
                              image: AssetImage('assets/images/signup.png'),
                            )),
                      ),
                    ),
                    _gap,
                    ReusableText(
                        text: 'Hello, Welcome',
                        fontSize: 40,
                        color: Colors.black),
                    ReusableText(
                        text: 'Fill the below fields for SignUp',
                        fontSize: 25,
                        color: Colors.black),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.text_increase_outlined,
 color: Colors.black,
                          ),
                          labelText: 'FirstName',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your FirstName';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.text_increase_outlined,
 color: Colors.black,
                          ),
                          labelText: 'LastName',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your LastName';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                          labelText: 'location',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneNumController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
 color: Colors.black,
                          ),
                          labelText: 'PhoneNumber',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
 color: Colors.black,
                          ),
                          labelText: 'Email',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        } else if (!value.contains('@')) {
                          return '@ is missing';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
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
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(kDark.value),
                            ),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        } else if (value.length < 6) {
                          return 'Password must containe 6 letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(kDark.value),
                            minimumSize: Size(200, 60)),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            final userData = AuthEntity(
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                location: locationController.text.trim(),
                                phoneNum: phoneNumController.text.trim(),
                                email: emailController.text.trim(),
                                password: password.text.trim());
                            ref
                                .read(authViewModelProvider.notifier)
                                .signUpFreelancer(userData, context);
                          }
                        },
                        child: ReusableText(
                          text: 'Sign Up',
                          fontSize: 20,
                          color: Color(kLight.value),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        child: ReusableText(
                          color: Color(kDark.value),
                          fontSize: 15,
                          text: 'Already have an account? Login',
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
