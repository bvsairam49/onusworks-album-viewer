import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/core/app_color.dart';
import 'package:onusworks_albums_app/core/app_style.dart';
import 'package:onusworks_albums_app/l10n/l10n.dart';
import 'package:onusworks_albums_app/service/database/user_database.dart';
import 'package:onusworks_albums_app/src/onboard/cubit/onboard_cubit.dart';
import 'package:onusworks_albums_app/src/onboard/state/onboard_state.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/custom_text_button_widget.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/show_custom_toast.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/text_form_field_with_validation.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/title_and_description_text_widget.dart';
import 'package:onusworks_albums_app/router/app_router.gr.dart';

@RoutePage()
class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardCubit(),
      child: const OnboardView(),
    );
  }
}

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserDatabase userDatabase = UserDatabase();
  @override
  void initState() {
    super.initState();
    loadAsynchronously();
  }

  loadAsynchronously() async {
    bool isUserCompletedOnboarded =
        await userDatabase.isUserCompletedOnboarding();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigate to next screen
      if (isUserCompletedOnboarded) {
        context.router.replace(const LoginRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<OnboardCubit, OnboardState>(
      builder: (context, state) {
        if (state is SuccessfulSaveState) {
          // Show toast after successful saving
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Toast.showCustomToast(
              context: context,
              message: l10n.onboardSuccess,
              status: ErrorStatus.success,
            );
          });
          // Navigate to next screen
          context.router.replace(const LoginRoute());
        } else if (state is ErrorState) {
          // Show error message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Toast.showCustomToast(
              context: context,
              message: state.errorMessage,
              status: ErrorStatus.error,
            );
          });
        } else if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.appBarColor,
            ),
          );
        }
        return Scaffold(
          backgroundColor: AppColor.appBackgroundColor,
          appBar: AppBar(
            title: Text(
              l10n.onboardAppBarTitle,
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
                    title: l10n.onboardingTitle,
                    description: l10n.onboardingDescription,
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
                      context.read<OnboardCubit>().saveCredentials(
                          userNameController.text.trim(),
                          passwordController.text.trim());
                    }
                  },
                  childWidget: Text(l10n.save),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
