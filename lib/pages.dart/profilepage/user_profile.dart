import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../contactpage/addcontacts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? usr = FirebaseAuth.instance.currentUser!;
  final firstname = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;
  final phone = FirebaseAuth.instance.currentUser!.phoneNumber;
  FirebaseStorage storage = FirebaseStorage.instance;
  File? pickedImage;
  bool isEmailVerified = false;
  

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() async {
        final fileName = basename(photo.path);
        final ref = storage.ref('images/').child(fileName);
        await ref.putFile(File(photo.path));
        pickedImage = tempImage;
      });
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void imagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
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
                        // ,
                        icon: const Icon(Icons.camera),
                        label: const Text("CAMERA"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                        // pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.image),
                        label: const Text("GALLERY"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     // Get.back();
                      //   },
                      //   icon: const Icon(Icons.close),
                      //   label: const Text("CANCEL"),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
          //   );
          // }
        });
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (isEmailVerified) {
        // print(isEmailVerified);
        Fluttertoast.showToast(msg: 'You are verified');
      } else {
        await user.sendEmailVerification();
        Fluttertoast.showToast(msg: 'Please check your email. ');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e as String);
    }
  }

  @override
  Widget build(BuildContext context) {
  final firstname = FirebaseAuth.instance.currentUser!.displayName;
  print(firstname);

    return Scaffold(
      
      backgroundColor:Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Account'),
        backgroundColor: Color.fromARGB(255, 170, 78, 184)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        border: Border.all(color: Colors.purple, width: 5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: ClipOval(
                        child: pickedImage != null
                            ? Image.file(
                                pickedImage!,
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/logo.jpg',
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
                        onPressed: () => imagePickerOption,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    onPressed: () => imagePickerOption(context),
                    icon: const Icon(Icons.add_a_photo_sharp),
                    label: const Text('UPLOAD IMAGE')),
              ),
              Center(
                child: ListTile(
                  leading: Text(
                    "$firstname",
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        color: Colors.grey),
                  ),
                ),
              ),
              ListTile(
                leading: Text(
                  "$email",
                  style:
                      const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                trailing: TextButton(
                  onPressed: sendVerificationEmail,
                  child: const Text(
                    "Verify Email",
                    style:TextStyle(
                      color:Colors.purple
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$phone",
                  style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: Colors.grey),
                ),
              ),
              (phone == null)
                  ? TextButton(
                      child: const Text(
                        "Edit",
                        style:TextStyle(
                        color:Colors.purple
                    )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Contact number')),
                                  TextButton(
                                      onPressed: () {
                                        UpdateContact(
                                            PhoneAuthCredential
                                                phoneNumber) async {
                                          await usr
                                              ?.updatePhoneNumber(phoneNumber);
                                        }
                                      },
                                      child: const Text('Save'))
                                ],
                              );
                            });
                      })
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Phone number not available",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.grey,
                            fontSize: 18),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    leading: const Text(
                      'Edit Trusted Contact',
                      style:
                          TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    trailing: TextButton(
                        child: const Text(
                          'Edit',
                          style:TextStyle(
                          color:Colors.purple
                    )
                          ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddContactsPage()));
                          ;
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}