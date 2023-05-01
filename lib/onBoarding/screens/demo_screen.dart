// ignore_for_file: prefer_const_constructors

import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/onBoarding/widget/custom_checbox.dart';
import 'package:dating_app/onBoarding/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widget/customButton.dart';
import '../widget/customtextheader.dart';

class DemoGraphic extends StatelessWidget {
  final TabController tabController;
  const DemoGraphic({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final dbrep = Provider.of<DataBaseRepository>(context);
    final user = Provider.of<DataBaseRepository>(context).nuser;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextHeader(
                    tabController: tabController, title: 'What\'s your Gender'),
                SizedBox(
                  height: 10,
                ),
                CustomCheckBox(
                  tabController: tabController,
                  title: 'MALE',
                  value: user?.gender == 'Male',
                  onchanged: (bool? p0) {
                    dbrep.copyWith(gender: 'Male');
                    print(dbrep.nuser?.gender);

                    dbrep.updateUser();
                  },
                ),
                CustomCheckBox(
                  tabController: tabController,
                  title: 'FEMALE',
                  value: user?.gender == 'Female',
                  onchanged: (p0) {
                    dbrep.copyWith(gender: 'Female');
                    print(dbrep.nuser?.gender);
                    dbrep.updateUser();
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                CustomTextHeader(
                    tabController: tabController, title: 'What\'s your Age'),
                CustomTextField(
                  tabController: tabController,
                  title: 'Enter Your\'s Age',
                  controller: controller,
                  onchanged: (p0) {
                    user?.age = int.parse(p0);
                    dbrep.updateUser();
                  },
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 3,
                  selectedColor: Theme.of(context).primaryColor,
                  unselectedColor: Theme.of(context).backgroundColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  tabController: tabController,
                  text: 'Next Step',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
