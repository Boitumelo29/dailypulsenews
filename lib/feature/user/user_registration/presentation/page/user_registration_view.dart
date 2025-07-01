import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/common_widgets/common_widgets.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/user/user_registration/application/bloc/user_registration_bloc.dart';
import 'package:dailypulsenews/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegistrationView extends StatelessWidget {
  const UserRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    final GlobalKey formKey = GlobalKey<FormState>();

    return BlocConsumer<UserRegistrationBloc, UserRegistrationState>(
      listener: _listener,
      builder: (context, state) {
        final loginSelected = state.loginSelected;
        final signupSelected = state.signUpSelected;
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    context.loc.dailyPulseNews,
                    style: context.textTheme.headlineLarge
                        ?.copyWith(color: context.colorScheme.primary),
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      Assets.lib.assets.pulseNewsLogo.path,
                      height: 300,
                      width: 300,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 750,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 15,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RegistrationButton(
                                  onTap: () {
                                    context.read<UserRegistrationBloc>().add(
                                        RegistrationSelected(
                                            registrationType:
                                                RegistrationType.login));
                                  },
                                  title: context.loc.login,
                                  selected: loginSelected,
                                ),
                                RegistrationButton(
                                  onTap: () {
                                    context.read<UserRegistrationBloc>().add(
                                        RegistrationSelected(
                                            registrationType:
                                                RegistrationType.sign));
                                  },
                                  title: context.loc.signup,
                                  selected: signupSelected,
                                )
                              ],
                            ),
                            if (signupSelected)
                              LongTextFieldForm(
                                  onChanged: (value) {},
                                  controller: username,
                                  labelText: context.loc.username,
                                  validator: (value) {
                                    return Validation.usernameValidation(value);
                                  }),
                            LongTextFieldForm(
                                controller: email,
                                onChanged: (value) {},
                                labelText: context.loc.email,
                                hintText: context.loc.email,
                                validator: (value) {
                                  return Validation.emailValidation(value);
                                }),
                            LongTextFieldForm(
                                controller: password,
                                onChanged: (value) {},
                                labelText: context.loc.password,
                                hintText: context.loc.password,
                                validator: (value) {
                                  return Validation.passwordValidation(value);
                                }),
                            if (loginSelected)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(context.loc.forgotPassword),
                                ),
                              ),
                            if (signupSelected)
                              LongTextFieldForm(
                                  onChanged: (value) {},
                                  labelText: context.loc.confirmPassword,
                                  hintText: context.loc.confirmPassword,
                                  validator: (value) {
                                    return Validation.passwordConformValidation(
                                        value, password.text);
                                  }),
                            LongButton(
                                onTap: () {
                                  context.router.pushAndPopUntil(
                                      HeadlinesRoute(),
                                      predicate: (route) => false);

                                  // if ((formKey.currentState as FormState)
                                  //     .validate()) {
                                  //   loginSelected
                                  //       ? context
                                  //           .read<UserRegistrationBloc>()
                                  //           .add(Login(
                                  //               email: email.text.trim(),
                                  //               password: password.text.trim()))
                                  //       : context
                                  //           .read<UserRegistrationBloc>()
                                  //           .add(SignUp(
                                  //               email: email.text.trim(),
                                  //               password: password.text.trim(),
                                  //               username:
                                  //                   username.text.trim()));
                                  // }
                                },
                                title: loginSelected
                                    ? context.loc.login
                                    : context.loc.signup,
                                isLoading: false),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _listener(BuildContext context, UserRegistrationState state) {
    state.loginEitherFailureOrUnit.fold(
        () {},
        (eitherFailureOrUnit) => eitherFailureOrUnit.fold((failure) {}, (unit) {
              context.router.pushAndPopUntil(HeadlinesRoute(),
                  predicate: (route) => false);
            }));

    state.signupEitherFailureOrUnit.fold(
        () {},
        (eitherFailureOrUnit) => eitherFailureOrUnit.fold((failure) {}, (unit) {
              context.router.pushAndPopUntil(HeadlinesRoute(),
                  predicate: (route) => false);
            }));
  }
}

