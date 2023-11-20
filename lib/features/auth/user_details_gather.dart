import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/bloc/profile/profile_bloc.dart';
import 'package:hybrid/models/user_model.dart';
import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/buttons.dart';
import 'package:hybrid/utils/components/components.dart';
import 'package:hybrid/utils/components/input_fields.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../utils/components/background_illustration.dart';

class UserDetailsGatheringScreen extends StatefulWidget {
  static String pathRoute = '/gather-user-details';

  const UserDetailsGatheringScreen({super.key});

  @override
  State<UserDetailsGatheringScreen> createState() =>
      _UserDetailsGatheringScreenState();
}

class _UserDetailsGatheringScreenState
    extends State<UserDetailsGatheringScreen> {
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  File? profielImage;
  File? bannerImage;

  pickImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: imageSource);

    if (_file != null) {
      setState(() {
        profielImage = File(_file.path);
      });
    }
  }

  pickBannerImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: imageSource);

    if (_file != null) {
      setState(() {
        bannerImage = File(_file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundIllustrations.backGroundIllustration(
              context: context, top: MediaQuery.of(context).size.height * 0.6),
          BackGroundIllustrations.backGroundIllustration(
              context: context,
              top: -MediaQuery.of(context).size.height * 0.1,
              left: -MediaQuery.of(context).size.width * 1.5),
          _buildFields(context)
        ],
      ),
    );
  }

  _buildFields(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("added successfully"),
              backgroundColor: Colors.amber,
            ),
          );
          // Future.delayed(Duration(seconds: 1)).then((value) {
          //   BlocProvider.of<ProfileBloc>(context).add(ProfileInitialEvent());
          // });
        }
        if (state is ProfileFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed " + state.errorMsg),
            backgroundColor: Colors.redAccent,
          ));
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: double.maxFinite,
                    child: GestureDetector(
                      child: bannerImage != null
                          ? Image.file(
                              bannerImage!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.abc),
                      onTap: () => UtilityComponents.selectImageSheet(
                          context: context, onTap: pickBannerImage),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              width: 2, color: AppColorConstants.black)),
                      child: GestureDetector(
                          onTap: () => UtilityComponents.selectImageSheet(
                              context: context, onTap: pickImage),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: profielImage != null
                                ? FileImage(profielImage!)
                                : null,
                          ))),
                  CustomInputFields.inputField(
                      controller: nameController,
                      context: context,
                      hintText: "Enter your name",
                      title: 'Name'),
                  const SizedBox(height: 10),
                  CustomInputFields.genderInputField(
                      onTap: () {
                        UtilityComponents.selectGendersheet(
                            context: context, controller: genderController);
                      },
                      controller: genderController,
                      context: context,
                      hintText: "Select Gender",
                      title: 'Gender'),
                  const SizedBox(height: 10),
                  CustomInputFields.inputFieldWithTailButton(
                      controller: locationController,
                      onTap: () {
                        print('get location');
                      },
                      icon: const Icon(Ionicons.locate),
                      context: context,
                      hintText: "Location",
                      title: 'Location'),
                  const SizedBox(height: 10),
                  CustomInputFields.inputField(
                      controller: mobileController,
                      context: context,
                      hintText: "Enter your phone number",
                      title: 'Mobile Number'),
                  const SizedBox(height: 20),
                  CustomButtons.flatButton(
                      onTap: () {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileUpdateEvent(
                                bannerImage: bannerImage,
                                profileImage: profielImage,
                                userModel: UserModel(
                                  phoneNumber: mobileController.text,
                                  fullName: nameController.text,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  username: nameController.text,
                                )));
                      },
                      bgColor: AppColorConstants.teal,
                      padding: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is ProfileLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Save',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 18,
                                          color: AppColorConstants.white),
                                ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
