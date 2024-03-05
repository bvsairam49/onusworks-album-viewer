import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/core/app_color.dart';
import 'package:onusworks_albums_app/core/app_style.dart';
import 'package:onusworks_albums_app/l10n/l10n.dart';
import 'package:onusworks_albums_app/src/login/cubit/login_cubit.dart';
import 'package:onusworks_albums_app/src/login/state/login_state.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/custom_text_button_widget.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/show_custom_toast.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/text_form_field_with_validation.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/title_and_description_text_widget.dart';
import 'package:onusworks_albums_app/router/app_router.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const LoginPageView(),
    );
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.appBarColor,
            ),
          );
        } else if (state is LoginError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Toast.showCustomToast(
              context: context,
              message: state.message,
              status: ErrorStatus.error,
            );
          });
        } else if (state is LoginAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.router.replace(const HomeRoute());
          });
        }
        return Scaffold(
          backgroundColor: AppColor.appBackgroundColor,
          appBar: AppBar(
            title: Text(
              l10n.login,
              style: AppStyle.appBarTitleStyle,
            ),
            backgroundColor: AppColor.appBarColor,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 30.0,
                  ),
                  child: HeaderWithTitleAndDescription(
                    title: l10n.loginTitle,
                    description: l10n.loginDescription,
                  ),
                ),
                TextFormFieldWithValidation(
                  controller: userNameController,
                  labelText: l10n.enterUsername,
                ),
                TextFormFieldWithValidation(
                  controller: passwordController,
                  labelText: l10n.enterPassword,
                  isSecureField: true,
                ),
                CustomTextButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().authenticateUser(
                            userNameController.text.trim(),
                            passwordController.text.trim(),
                          );
                    }
                  },
                  childWidget: Text(l10n.login),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
