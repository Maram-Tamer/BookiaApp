import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/extentions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => pop(context),
          child: Image.asset(AppImages.back, width: 40, height: 40),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _authListener,
        child: _signInBody(),
      ),
      bottomNavigationBar: _registerPrompt(context),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is AuthSuccessState) {
  pushAndRemoveUntil(context, AppNavigator.homeRoute);
    } else if (state is AuthErrorState) {
      pop(context);
      showErrorDialog(context, state.error);
    } else {
      showLoadingDialog(context);
    }
  }

  Widget _signInBody() {
    final auth = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: auth.formKey,
          child: Column(
            children: [
              Text(
                'Hello again! Sign in to continue',
                style: TextStyles.getSize30(),
              ),
              Gap(28),
              CustomTextField(
                controller: auth.emailController,
                hintText: 'Email address',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Email required';
                  }
                  return null;
                },
              ),
              Gap(18),
              CustomTextField(
                isPassword: true,
                controller: auth.passwordController,
                hintText: 'Password',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Password required';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyles.getSize16(),
                    ),
                  ),
                ],
              ),
              Gap(28),
              MainButton(
                text: 'Sign In',
                onPressed: () {
                  if (auth.formKey.currentState!.validate()) {
                    auth.login();
                  }
                },
              ),
              Gap(36),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    '  Or sign in with  ',
                    style: TextStyles.getSize16(fontSize: 14),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              Gap(28),
              _socialRow(),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _registerPrompt(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("New here? ", style: TextStyles.getSize16()),
          TextButton(
            onPressed: () => pushWithReplacement(context, AppNavigator.signUpRoute),
            child: Text(
              'Create Account',
              style: TextStyles.getSize16(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialRow() {
    return Row(
      children: [
        SocialButton(iconPath: AppImages.googleSvg, onTap: () {}),
        SizedBox(width: 8),
        SocialButton(iconPath: AppImages.facebookSvg, onTap: () {}),
        SizedBox(width: 8),
        SocialButton(iconPath: AppImages.appleSvg, onTap: () {}),
      ],
    );
  }
}
