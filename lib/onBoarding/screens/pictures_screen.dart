// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/onBoarding/widget/customButton.dart';
import 'package:dating_app/onBoarding/widget/custom_image.dart';
import 'package:dating_app/onBoarding/widget/customtextheader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../firebase/databaseRep.dart';
import '../../modal/user_modal.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;
  const Pictures({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userImages = Provider.of<DataBaseRepository>(context);
    final docid = userImages.docId;

    return docid == null
        ? EmptyPictureBox(tabController: tabController)
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(docid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var snapData = snapshot.data!;
              userImages.nextUser(snapData);

              final images = userImages.nuser?.imageUrls;
              final imageCount = images?.length;
              return PictureScreenBox(
                  tabController: tabController,
                  imageCount: imageCount,
                  images: images);
            },
          );
  }
}

class EmptyPictureBox extends StatelessWidget {
  const EmptyPictureBox({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  title: 'Add 2 or More Pictures '),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        crossAxisCount: 3,
                        childAspectRatio: 0.66),
                    itemBuilder: (context, index) =>
                        CustomImageContainer(tabController: tabController)),
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 4,
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
    );
  }
}

class PictureScreenBox extends StatelessWidget {
  const PictureScreenBox({
    Key? key,
    required this.tabController,
    this.imageCount,
    this.images,
  }) : super(key: key);

  final TabController tabController;
  final int? imageCount;
  final List? images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  title: 'Add 2 or More Pictures '),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8,
                      crossAxisCount: 3,
                      childAspectRatio: 0.66),
                  itemBuilder: (context, index) => imageCount! > index
                      ? CustomImageContainer(
                          tabController: tabController,
                          imageUrl: images![index],
                        )
                      : CustomImageContainer(tabController: tabController),
                ),
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 4,
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
    );
  }
}
