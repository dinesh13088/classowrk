import 'package:classwork/controller/sample_list_controller.dart';
import 'package:classwork/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext dashboardContext) {
    final SampleListController sampleListController =
        Get.put(SampleListController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => sampleListController.insertDataIntoList('Hello'),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () =>
                    sampleListController.deleteDataFromList('Hello')),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              child: Icon(Icons.logout),
              onTap: () {
                showDialog(
                    context: dashboardContext,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                          title: Text('signout Dialog'),
                          icon: Icon(Icons.warning),
                          content: Text('Are you sure want to signout'),
                          actions: [
                            GestureDetector(
                              child: Text('yes'),
                              onTap: () async {
                                final authService = FirebaseAuthService();
                                authService.signOutUser();
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove('uId');
                                Navigator.of(dialogContext).pop();
                                Navigator.of(dashboardContext)
                                    .pushReplacementNamed('/login');
                              },
                            ),
                            GestureDetector(
                              child: Text('No'),
                              onTap: () {
                                Navigator.of(dialogContext).pop();
                              },
                            )
                          ]);
                    });
              },
            ),
          ],
        ),
        body: Obx(() {
          return ListView.builder(
              itemCount: sampleListController.sampleList.length,
              itemBuilder: (context, index) {
                final sampleData = sampleListController.sampleList[index];
                return Container(
                  color: Colors.grey.withOpacity(0.3),
                  padding: EdgeInsets.all(10),
                  child: Text('$sampleData'),
                );
              });
        }));
  }
}
