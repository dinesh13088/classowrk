import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? fullName;
  int? phoneNumber;
  String? address;
  String? email;

  UserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.email,
  });

  // this function is used to convert the flutter model object to firebase readable json
  toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
      'email': email,
    };
  }

  factory UserModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data();
    return UserModel(
        id: data['id'],
        fullName: data['full_name'],
        phoneNumber: data['phone_number'],
        address: data['address'],
        email: data['email']);
  }
}
