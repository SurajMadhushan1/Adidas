import 'package:adidas/components/custom_buttons/custom_button1.dart';
import 'package:adidas/components/custom_text_field/custom_textfield1.dart';
import 'package:adidas/providers/auth_provider.dart';
import 'package:adidas/providers/profile_provider.dart';
import 'package:adidas/screens/home_screen/admin/admin_screen.dart';
import 'package:adidas/utils/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, auth, profile, child) {
        return Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://www.trendycovers.com/covers/1323357144.jpg"))),
                  ),
                  GestureDetector(
                    onTap: () {
                      profile.pickProfleImage(context);
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profile.pickedImage == null
                            ? NetworkImage(auth.userModel!.image)
                            : FileImage(profile.pickedImage!) as ImageProvider,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: const Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextField1(
                      label: "User Name",
                      icon: Icons.person,
                      controller: profile.nameController),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton1(
                      size: size,
                      text: "Update",
                      bgColor: Colors.blue,
                      ontap: () {
                        profile.updateUserData(context);
                      })
                ],
              ),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomNavigators.goTo(context, const AdminScreen());
        },
        child: const Icon(Icons.admin_panel_settings_sharp),
      ),
    );
  }
}
