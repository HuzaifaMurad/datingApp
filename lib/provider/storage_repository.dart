// import 'dart:io';

// import 'package:dating_app/firebase/databaseRep.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// import '../modal/modal.dart';

// class StorageRepository {
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   Future<void> uploadImage(User user, XFile image) async {
//     try {
//       await storage
//           .ref('${user.id}/${image.name}')
//           .putFile(
//             File(image.path),
//           )
//           .then((p0) => DataBaseRepository().updateUserPictures(image.name));
//     } catch (e) {
//       print('storage screen : $e');
//     }
//   }

//   Future<String> getDownlaodUrl(User user, String imageName) async {
//     String downloadUrl =
//         await storage.ref('${user.id}/${imageName}').getDownloadURL();
//     return downloadUrl;
//   }
// }
