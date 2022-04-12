import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/CacheHelper.dart/cache_helper.dart';
import 'package:social_app/components.dart';
import '../../constants.dart';
import '../HomeLayout/home_layout.dart';
import '../ShopRegisterScreen/shop_register_screen.dart';
import 'Cubit/cubit_login.dart';
import 'Cubit/stats_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {

            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );

          }
          if(state is SocialLoginSuccessState){

            uId = state.uid;
            CacheHelper.saveData(key:'uId', value: state.uid)
                .then((value) => navigateNoBack(const HomeLayout(),context));


            
          }


        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(

                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            iconData: Icons.email,
                            label: 'Email Address',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your email address';
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(

                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            isPassword: SocialLoginCubit.get(context).isPassword,
                            iconData: Icons.lock,
                            isPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            suffix: SocialLoginCubit.get(context).suffix,
                            label: 'Password',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialLoginCubit.get(context).loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigate(
                                  SocialRegisterScreen(),
                                  context,
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
