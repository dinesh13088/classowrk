import 'package:classwork/model/user_model.dart';
import 'package:classwork/services/firebase_database_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final _formKeyupdate = GlobalKey<FormState>(); //underscore : private
  final _fullNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _emailRegexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  //function to set form field controllers using user model data
  void setUserModelDataToFormControllers(BuildContext context) {
    final UserModel? userModelDetails =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    if (userModelDetails != null) {
      if (userModelDetails.fullName != null) {
        _fullNameController.text = userModelDetails.fullName!;
      }

      if (userModelDetails.phoneNumber != null) {
        _phoneNumberController.text = userModelDetails.phoneNumber!.toString();
      }

      if (userModelDetails.address != null) {
        _streetAddressController.text = userModelDetails.address!;
      }
      if (userModelDetails.email != null) {
        _emailAddressController.text = userModelDetails.email!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    setUserModelDataToFormControllers(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKeyupdate,
        child: ListView(
          children: [
            TextFormField(
              controller: _fullNameController,
              keyboardType: TextInputType.name,
              maxLength: 30,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter full name',
              ),
              validator: (fullNameValue) {
                if (fullNameValue == null || fullNameValue.trim().isEmpty) {
                  return 'Please Enter Full Name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailAddressController,
              maxLength: 30,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email address',
              ),
              validator: (emailValue) {
                if (emailValue == null || emailValue.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                final regex = RegExp(_emailRegexPattern);
                if (!regex.hasMatch(emailValue)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your phone number',
              ),
              validator: (phoneNumberValue) {
                if (phoneNumberValue == null ||
                    phoneNumberValue.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _streetAddressController,
              keyboardType: TextInputType.streetAddress,
              maxLength: 20,
              maxLines: 4, //lines or height of box
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your address',
              ),
              validator: (streetAddressValue) {
                if (streetAddressValue == null ||
                    streetAddressValue.trim().isEmpty) {
                  return 'Please Enter address';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_formKeyupdate.currentState != null) {
                  if (_formKeyupdate.currentState!.validate()) {
                    _formKeyupdate.currentState!.save();

                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? userId = prefs.getString('uId');

                    final userModelRequest = UserModel(
                      id: userId,
                      fullName: _fullNameController.text,
                      phoneNumber: int.parse(_phoneNumberController.text),
                      address: _streetAddressController.text,
                    );

                    final databaseService = FirebaseDatabaseService();
                    if (userId != null) {
                      final userModelResponse =
                          await databaseService.updateUserUsingUID(
                              uID: userId, userModel: userModelRequest);

                      if (userModelResponse != null) {
                        Navigator.of(context).pop();
                      }
                    }
                  }
                }
              },
              child: Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
