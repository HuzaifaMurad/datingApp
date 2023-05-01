// ignore_for_file: prefer_const_constructors

import 'package:dating_app/onBoarding/widget/customButton.dart';
import 'package:dating_app/onBoarding/widget/custom_text_field.dart';
import 'package:dating_app/onBoarding/widget/customtextheader.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmailVerification extends StatelessWidget {
  final TabController tabController;
  const EmailVerification({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  title: 'Did You Get the Verification Code?'),
              CustomTextField(
                tabController: tabController,
                title: 'Enter your code',
                controller: controller,
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                tabController: tabController,
                text: 'Next Step',
                newUser: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
