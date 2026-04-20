import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/functions/validations.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/styles/app_text_styles.dart';
import 'package:se7ety/core/utils/styles/colors.dart';
import 'package:se7ety/core/widget/custom_text_form_field.dart';
import 'package:se7ety/core/widget/dialogs.dart';
import 'package:se7ety/core/widget/main_button.dart';
import 'package:se7ety/core/widget/password_text_form_field.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7ety/features/auth/presentation/page/widget/social_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          if (widget.userType == UserTypeEnum.patient) {
            pushToBase(context, Routes.patientMainApp);
          } else {}
        } else if (state is AuthErrorState) {
          pop(context);
          showMyDialog(context, state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(color: AppColors.primaryColor),
        ),
        body: _loginForm(context),
      ),
    );
  }

  Center _loginForm(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo, height: 200),
                const SizedBox(height: 20),
                Text(
                  'سجل دخول الان كـ "${handleUserType()}"',
                  style: AppTextStyles.title18.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  textAlign: TextAlign.end,
                  hintText: 'Sayed@example.com',
                  prefixIcon: Icon(Icons.email_rounded),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'من فضلك ادخل الايميل';
                    } else if (!isEmailValid(value)) {
                      return 'من فضلك ادخل الايميل صحيحا';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 25.0),
                PasswordTextFormField(
                  hintText: '********',
                  controller: cubit.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsetsDirectional.only(top: 10, start: 10),
                  child: Text('نسيت كلمة السر ؟', style: AppTextStyles.small14),
                ),
                const Gap(20),
                MainButton(
                  onPressed: () async {
                    if (cubit.formKey.currentState!.validate()) {
                      await cubit.login();
                    }
                  },
                  text: "تسجيل الدخول",
                ),
                const Gap(30),
                SocialLogin(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لدي حساب ؟',
                        style: AppTextStyles.body16.copyWith(
                          color: AppColors.darkColor,
                        ),
                      ),
                      const Gap(3),
                      TextButton(
                        onPressed: () {
                          pushReplacement(
                            context,
                            Routes.register,
                            extra: widget.userType,
                          );
                        },
                        child: Text(
                          'سجل الان',
                          style: AppTextStyles.body16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
