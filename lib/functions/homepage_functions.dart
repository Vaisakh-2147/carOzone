import 'dart:io';

import 'package:car_o_zone/screens/drawer/about_us.dart';
import 'package:car_o_zone/screens/firebase/favorite.dart';
import 'package:car_o_zone/screens/firebase/auth/login_user.dart';
import 'package:car_o_zone/screens/drawer/privacypolicy.dart';
import 'package:car_o_zone/screens/hive/save_list.dart';
import 'package:car_o_zone/screens/drawer/terms_and_conditions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  final firestore1 = FirebaseFirestore.instance;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  void handleFavoriteChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 203, 60, 113),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(162, 153, 169, 1),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                if (user != null) {
                  String email = user!.email ?? '';
                  print('user email:${user!.email}');

                  QuerySnapshot<Map<String, dynamic>> querySnapshot =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .where('email', isEqualTo: user!.email)
                          .get();

                  if (querySnapshot.docs.isNotEmpty) {
                    DocumentSnapshot<Map<String, dynamic>> snapshot =
                        querySnapshot.docs.first;
                    String name = snapshot.get('userName');
                    String? image = snapshot.get('profile');
                    userNameController.text = name;
                    emailController.text = email;
                    String documentId = snapshot.id;
                    selectedImage = image;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('User Profile'),
                              scrollable: true,
                              content: StatefulBuilder(
                                builder: (context, setState) =>
                                    SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.teal,
                                        backgroundImage: image != null
                                            ? FileImage(File(
                                                image!,
                                              ))
                                            : null,
                                        child: InkWell(
                                            onTap: () async {
                                              print('image picking');
                                              String? pickimage =
                                                  await pickImageFromGallery();

                                              setState(() {
                                                image = pickimage;
                                              });
                                            },
                                            child: image != null
                                                ? ClipOval(
                                                    child: Image.file(
                                                      File(image!),
                                                      fit: BoxFit.cover,
                                                      height: 150,
                                                      width: 150,
                                                    ),
                                                  )
                                                : null),
                                      ),
                                      const SizedBox(height: 30),
                                      TextFormField(
                                        controller: userNameController,
                                        decoration: const InputDecoration(
                                            labelText: 'User name'),
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: emailController,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                            labelText: 'Email '),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      selectedImage = image;
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () async {
                                      firestore1
                                          .collection('users')
                                          .doc(documentId)
                                          .update({
                                        'userName': userNameController.text,
                                        'profile': image
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text(' Edited sucessfully')));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'))
                              ]);
                        });
                  }
                }
              }),
          ListTile(
            leading: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              'Favorite',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(
                        carId: '',
                        imageUrl: '',
                        text: '',
                        prize: '',
                        fueltype: '',
                        transmission: '',
                        enginesize: '',
                        mileage: '',
                        safetyrating: '',
                        groundclearance: '',
                        seatingcapacity: '',
                        carsize: '',
                        carfueltank: '',
                      )));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.save,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              'Saved Comparison List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SavedDataListScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.security,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PrivacypolicyScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              'About Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AboutScreeen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rule,
              size: 30,
              color: Colors.black,
            ),
            title: const Text(
              'Terms & Conditions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TermsandConditionScreen()));
            },
          ),
          // Other ListTiles
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 30,
              color: Colors.black,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              showLogoutDialog(context);
            },
          ),
          const SizedBox(
            height: 149,
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          Center(child: Text('login with:${user?.email ?? "N/"}')),
          const Divider()
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                } catch (e) {
                  print("Error logging out: $e");
                }
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

Future<String?> pickImageFromGallery() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return pickedImage.path;
  }
  return null;
}
