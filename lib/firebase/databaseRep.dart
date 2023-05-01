import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../modal/modal.dart';
import '../provider/storage_repository.dart';

class DataBaseRepository with ChangeNotifier {
  User? nuser;
  String? docId;

  void copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    List<dynamic>? imageUrls,
    List<dynamic>? interests,
    String? bio,
    String? jobTitle,
    String? location,
  }) {
    nuser = User(
      name: name ?? nuser?.name,
      age: age ?? nuser?.age,
      gender: gender ?? nuser?.gender,
      imageUrls: imageUrls ?? nuser?.imageUrls,
      interests: interests ?? nuser?.interests,
      bio: bio ?? nuser?.bio,
      jobTitle: jobTitle ?? nuser?.jobTitle,
      location: location ?? nuser?.location,
    );

    notifyListeners();
  }

  Future fetchuser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .get()
        .then((element) {
      nuser = User(
        id: docId,
        name: element.data()!['name'],
        age: element.data()!['age'],
        gender: element.data()!['gender'],
        imageUrls: element.data()!['imgeUrl'],
        interests: element.data()!['interest'],
        bio: element.data()!['bio'],
        jobTitle: element.data()!['jobTitle'],
        location: element.data()!['location'],
        liked: element.data()!['liked'],
      );
      print('fetched');
    }).catchError((error) {
      print('this is: $error');
    });

    // else{

    // }  await FirebaseFirestore.instance
    //       .collection('users')
    //       .get()
    //       .then((QuerySnapshot value) {
    //     value.docs.forEach((element) {
    //       nuser = User(
    //         id: element['id'],
    //         name: element['name'],
    //         age: element['age'],
    //         gender: element['gender'],
    //         imageUrls: element['imgeUrl'],
    //         interests: element['interest'],
    //         bio: element['bio'],
    //         jobTitle: element['jobTitle'],
    //         location: element['location'],
    //       );
    //     });
    //   });
    notifyListeners();
  }

  Future fetchLoggedUser(String loggId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(loggId)
        .get()
        .then((element) {
      nuser = User(
        id: docId,
        name: element.data()!['name'],
        age: element.data()!['age'],
        gender: element.data()!['gender'],
        imageUrls: element.data()!['imgeUrl'],
        interests: element.data()!['interests'],
        bio: element.data()!['bio'],
        jobTitle: element.data()!['jobTitle'],
        location: element.data()!['location'],
        liked: element.data()!['liked'],
      );
      print('fetched');
    }).catchError((error) {
      print('this is: $error');
    });
  }

  // Stream<DocumentSnapshot<Object?>> getUsers() async* {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .snapshots()
  //       .forEach((querySnapshot) {
  //     querySnapshot.docs.forEach((DocumentSnapshot element) {
  //       nuser = User(
  //         id: element.id,
  //         name: element['name'],
  //         age: element['age'],
  //         gender: element['gender'],
  //         imageUrls: element['imgeUrl'],
  //         interests: element['interest'],
  //         bio: element['bio'],
  //         jobTitle: element['jobTitle'],
  //         location: element['location'],
  //       );
  //     });
  //   });
  // }

  User? nextUser(DocumentSnapshot element) {
    User myUser = User(
        id: docId,
        name: element['name'],
        age: element['age'],
        gender: element['gender'],
        imageUrls: element['imgeUrl'],
        interests: element['interests'],
        bio: element['bio'],
        jobTitle: element['jobTitle'],
        location: element['location'],
        liked: element['liked']);
    nuser = myUser;
    return myUser;
  }

  Future<void> uploadImage(XFile image) async {
    try {
      await FirebaseStorage.instance
          .ref('$docId/${image.name}')
          .putFile(
            File(image.path),
          )
          .then((p0) => updateUserPictures(image.name));
    } catch (e) {
      print('storage screen : $e');
    }
  }

  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await FirebaseStorage.instance
        .ref('$docId/$imageName')
        .getDownloadURL();
    return FirebaseFirestore.instance.collection('users').doc(docId).update(
      {
        'imgeUrl': FieldValue.arrayUnion(
          [downloadUrl],
        ),
      },
    );
  }

  Future<void> createUser(User? user, String? userUid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .set(user!.toMap())
        .then((value) {
      docId = userUid;
      print('firebase  user,ID:$userUid');
    });
  }

  Future<void> updateUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update({
          'name': nuser?.name,
          'age': nuser?.age,
          'gender': nuser?.gender,
          'imgeUrl': nuser?.imageUrls,
          'bio': nuser?.bio,
          'jobTitle': nuser?.jobTitle,
        })
        .then((value) => print('new user updated'))
        .catchError((error) {
          print(error);
        });
  }
}
