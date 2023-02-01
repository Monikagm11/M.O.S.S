import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import '../model.dart/contacts.dart';
import '../db.dart/dbservices.dart';
import 'package:image_picker/image_picker.dart';
import '../pages.dart/addcontacts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final name = FirebaseAuth.instance.currentUser.displayName;
  final email = FirebaseAuth.instance.currentUser.email;
  final phone = FirebaseAuth.instance.currentUser.phoneNumber;

  User user = FirebaseAuth.instance.currentUser;

  late File pickedImage;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Tcontact> contactList = [];

  Tcontact contact;

  void showContact(Tcontact contact) async {
    await databaseHelper.getContactList();
  }

  void ImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Container(
                color: Colors.white,
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Pic Image From",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("CAMERA"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("GALLERY"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("CANCEL"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        });
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() async {
        pickedImage = tempImage;
        final fileName = basename(photo.path);
        final destination = 'files/$fileName';
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/');
        await ref.putFile(File(photo.path));
      });
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  verifyEmail() async {
    if (user != null && !user.emailVerified) {
      var context;
      await user.sendEmailVerification();
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('IMAGE PICKER'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipOval(
                    child: pickedImage != null
                        ? Image.file(
                            pickedImage,
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      ImagePickerOption(context);
                    },
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    'Username: $name',
                    style: const TextStyle(fontSize: 18.0),
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
                                          decoration: InputDecoration(
                                              labelText: 'Contact number')),
                                      TextButton(
                                          onPressed: () {
                                            UpdateContact(
                                                PhoneAuthCredential
                                                    phoneNumber) async {
                                              await user?.updatePhoneNumber(
                                                  phoneNumber);
                                            }

                                            ;
                                          },
                                          child: Text('Save'))
                                    ],
                                  ),
                                );
                              });
                        })),
                ListTile(
                    leading: Text(
                      'Trusted Contact: $phone',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    trailing: TextButton(
                        child: const Text('Edit'),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddContactsPage()));
                          ;
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}