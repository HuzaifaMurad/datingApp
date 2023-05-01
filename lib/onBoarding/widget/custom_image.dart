// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/provider/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CustomImageContainer extends StatelessWidget {
  final TabController tabController;
  final String? imageUrl;
  const CustomImageContainer(
      {Key? key, required this.tabController, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newUser = Provider.of<DataBaseRepository>(context);
    final user = Provider.of<DataBaseRepository>(context).nuser;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border(
            bottom: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            top: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            right: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            left: BorderSide(color: Theme.of(context).primaryColor, width: 1),
          ),
        ),
        child: imageUrl == null
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () async {
                    ImagePicker _picker = ImagePicker();
                    final image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        // ignore: prefer_const_constructors
                        SnackBar(
                          content: Text('no image was selected'),
                        ),
                      );
                    }
                    if (image != null) {
                      print('uploading...');
                      newUser.uploadImage(image);
                    }
                  },
                  icon: Icon(Icons.add_circle),
                  color: Colors.red,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
