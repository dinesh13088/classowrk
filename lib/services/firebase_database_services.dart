import 'package:classwork/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseService {
  final dbInstance = FirebaseFirestore.instance;
  final userList = [];

  /// this function is used to get the users from database
  Future getSingleUser() async {
    try {
      CollectionReference usersCollection =
          await dbInstance.collection('users');
      final userDoc = await usersCollection.doc('user1').get();

      if (userDoc.exists) {
        print('The user1 details is ${userDoc.data()}');
      } else {
        print('Data not found');
      }
    } catch (e) {
      print('Error feteching data $e');
    }
  }

  /// this function is used to get list of users from collection in firebase
  Future getUsersInACollection() async {
    try {
      CollectionReference _userCollection =
          await dbInstance.collection('users');
      await _userCollection.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          userList.add(doc.data());
        }
      });
      print('users List ${userList.length}');
      return userList;
    } catch (e) {
      print('Error while getting users $e');
    }
  }

  // create a user in firebase firestore
  void createUser({required UserModel userModel}) async {
    try {
      CollectionReference _userCollection =
          await dbInstance.collection('users');
      await _userCollection.add(userModel.toJson()).whenComplete(() {
        print("user created success");
      });
    } catch (e) {
      print("something went $e");
    }
  }

  /// This function is used to get user details using uid
  Future<UserModel?> getUserDetailsUsingUID({required String uId}) async {
    try {
      CollectionReference _userCollection =
          await dbInstance.collection('users');
      final snapShot = await _userCollection.where('id', isEqualTo: uId).get();
      final userModel = await snapShot.docs.map((doc) {
        return UserModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).single;

      return userModel;
    } catch (e) {
      print('something went wrong $e');
    }
    return null;
  }

//get all users in a database
  Future<List<UserModel>> getAllUsersInADatabase() async {
    try {
      CollectionReference _usersCollection =
          await dbInstance.collection('users');
      final snapShot = await _usersCollection.get();
      return await snapShot.docs
          .map((doc) => UserModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();
    } catch (e) {
      print("something went wrong $e");
    }
    return [];
  }

  // update a user in firebase database
  Future<UserModel?> updateUserUsingUID(
      {required String uID, required UserModel userModel}) async {
    try {
      CollectionReference _usersCollection =
          await dbInstance.collection('users');
      final documentSnapshot =
          await _usersCollection.where('id', isEqualTo: uID).get();

      if (documentSnapshot.docs.isNotEmpty) {
        final documentId = documentSnapshot.docs.single.id;
        await _usersCollection.doc(documentId).update(userModel.toJson());
        final userModelResponse = await documentSnapshot.docs.map((doc) {
          return UserModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>);
        }).single;

        return userModelResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("something went wrong $e");
    }
    return null;
  }

  // delete a user in firebase database
  Future<List<UserModel>> deleteUserUsingUID({required String uID}) async {
    try {
      CollectionReference _usersCollection =
          await dbInstance.collection('users');
      final documentSnapshot =
          await _usersCollection.where('id', isEqualTo: uID).get();
      if (documentSnapshot.docs.isNotEmpty) {
        final documentId = documentSnapshot.docs.first.id;
        await _usersCollection.doc(documentId).delete();

        return await documentSnapshot.docs
          .map((doc) => UserModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("something went wrong $e");
    }
    return [];
  }
}
