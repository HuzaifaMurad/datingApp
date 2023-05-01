// ignore_for_file: prefer_const_constructors

import 'package:dating_app/onBoarding/widget/customButton.dart';
import 'package:dating_app/onBoarding/widget/custom_text_field.dart';
import 'package:dating_app/onBoarding/widget/customtextheader.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Email extends StatelessWidget {
  final TabController tabController;
  const Email({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  title: 'What\'s your email address?'),
              CustomTextField(
                tabController: tabController,
                title: 'Enter your email',
                controller: emailController,
              ),
              SizedBox(
                height: 100,
              ),
              CustomTextHeader(
                  tabController: tabController,
                  title: 'What\'s your Password?'),
              CustomTextField(
                tabController: tabController,
                title: 'Enter your password',
                controller: passwordController,
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                tabController: tabController,
                text: 'Next Step',
                emailControler: emailController,
                passwordControler: passwordController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
