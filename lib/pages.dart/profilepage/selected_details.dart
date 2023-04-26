import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'../contactpage/addcontacts.dart';

class SelectedDetails extends StatefulWidget {
  //const SelectedDetails({Key key}) : super(key: key);

  static const routeName = "/selected_details";


  @override
  State<SelectedDetails> createState() => _SelectedDetailsState();
}

class _SelectedDetailsState extends State<SelectedDetails> {
  final name = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;
  final phone = FirebaseAuth.instance.currentUser!.phoneNumber;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Expanded
          (
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    'Username: $name',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ListTile(
                leading: Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 18.0),
                ),

                // user!.emailVerified
                //     ? const Text(
                //         'verified',
                //         style: TextStyle(
                //             fontSize: 18.0, color: Colors.blueGrey),
                //       )
                //     : TextButton(
                //         onPressed: () => {verifyEmail()},
                //         child: const Text('Verify Email'))
              )
            ],
          ),
          ListTile(
              leading: Text(
                'Contact Number: $phone',
                style: const TextStyle(fontSize: 18.0),
              ),
              trailing: TextButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext) {
                          return Container(
                            child: Column(
                              children: [
                                TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Contact number')),
                                TextButton(
                                    onPressed: () {
                                      UpdateContact(
                                          PhoneAuthCredential
                                              phoneNumber) async {
                                        await user
                                            ?.updatePhoneNumber(phoneNumber);
                                      }
                                    },
                                    child: Text('Save'))
                              ],
                            ),
                          );
                        });
                  })),
        ],
      ),
    );
  }
}
