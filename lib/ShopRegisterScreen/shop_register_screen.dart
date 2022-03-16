import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/HomeLayout/home_layout.dart';
import 'package:social_app/ShopRegisterScreen/CubitForRegistration/register_cubit.dart';
import 'package:social_app/components.dart';
import '../CacheHelper.dart/cache_helper.dart';
import '../constants.dart';
import 'CubitForRegistration/register_stats.dart';

class SocialRegisterScreen extends StatelessWidget {
   SocialRegisterScreen({Key key}) : super(key: key);

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(

      create:(BuildContext context) => SocialRegistrationCubit(),

      child: BlocConsumer<SocialRegistrationCubit,SocialRegistrationStates>(
        listener: (context,state){

          if(state is SocialCreateUserSuccessState){
            uId = state.uid;
            CacheHelper.saveData(key:'uId', value: state.uid)
                .then((value) => navigateNoBack(const HomeLayout(),context));
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[

                        Text('Registration',style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),),

                        Text(
                          'Registration now to communicate with your friend',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(

                            controller: nameController,
                            textInputType: TextInputType.name,
                            iconData: Icons.person,
                            label: 'name',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your name';

                              }

                            }
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        defaultFormField(

                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            iconData: Icons.email,
                            label: 'Email Address',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your email address';

                              }

                            }
                        ),



                        const SizedBox(
                          height: 30,
                        ),

                        defaultFormField(

                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            isPassword: SocialRegistrationCubit.get(context).isPassword,
                            iconData: Icons.lock,
                            isPressed: (){
                              SocialRegistrationCubit.get(context).changePasswordVisibility();
                            },
                            suffix: SocialRegistrationCubit.get(context).suffix,
                            label: 'Password',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your password';

                              }

                            }
                        ),


                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(

                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            iconData: Icons.phone,
                            label: 'phone',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter phone';

                              }

                            }
                        ),


                        const SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition: state is! SocialRegistrationLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialRegistrationCubit.get(context).registrationUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,

                                );
                              }
                            },
                            text: 'Registration',
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
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

