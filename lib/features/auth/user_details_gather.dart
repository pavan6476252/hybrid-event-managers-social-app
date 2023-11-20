import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hybrid/bloc/profile/profile_bloc.dart';
import 'package:hybrid/models/user_model.dart';
import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/buttons.dart';
import 'package:hybrid/utils/components/components.dart';
import 'package:hybrid/utils/components/input_fields.dart';
import 'package:hybrid/utils/helper_functions.dart';
import 'package:hybrid/utils/permission_handler_util.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/components/background_illustration.dart';

class UserDetailsGatheringScreen extends StatefulWidget {
  static String pathRoute = '/gather-user-details';

  const UserDetailsGatheringScreen({super.key});

  @override
  State<UserDetailsGatheringScreen> createState() =>
      _UserDetailsGatheringScreenState();
}

class _UserDetailsGatheringScreenState extends State<UserDetailsGatheringScreen>
    with KeepAliveParentDataMixin {
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  File? profielImage;
  File? bannerImage;
  LocationInfo? locationInfo;
  DateTime dateOfBirth = DateTime.now();

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

  handleDatePick() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());
    if (dateTime != null) {
      dateOfBirth = dateTime;
      setState(() {});
    }
  }

  handlePermission() async {
    if (await PermissionHandlerUtil.requestPermissions([Permission.location])) {
      print("permission handling");
      locationInfo = await HelperFunctions.getLocationInfo();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    handlePermission();
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

          nameController.text ='hello';

        if (state is ProfileLoaded) {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("added successfully"),
              backgroundColor: Colors.amber,
            ),
          );

        }
        if (state is ProfileFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed " + state.errorMsg),
            backgroundColor: Colors.redAccent,
          ));
        }
      },
      builder: (context, state) {
       if(state is ProfileLoaded){
        // print(state.userModel);
        return Center(child: Text("data"),);
       }

        return SizedBox(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 180,
                            child: GestureDetector(
                              onTap: () => UtilityComponents.selectImageSheet(
                                context: context,
                                onTap: pickBannerImage,
                              ),
                              child: Container(
                                height: 140,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColorConstants.mainThemeColor
                                      .withOpacity(0.4),
                                ),
                                child: bannerImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          bannerImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Center(child: Icon(Icons.image)),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => UtilityComponents.selectImageSheet(
                                context: context,
                                onTap: pickImage,
                              ),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 2, color: AppColorConstants.black),
                                ),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppColorConstants
                                          .mainThemeColor
                                          .withOpacity(0.6),
                                      backgroundImage: profielImage != null
                                          ? FileImage(profielImage!)
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColorConstants.teal,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColorConstants.white,
                                          ),
                                          onPressed: () => UtilityComponents
                                              .selectImageSheet(
                                            context: context,
                                            onTap: pickImage,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(50),
//     border: Border.all(width: 2, color: AppColorConstants.black),
//   ),
//   child: Stack(
//     children: [
//       GestureDetector(
//         onTap: () => UtilityComponents.selectImageSheet(
//           context: context,
//           onTap: pickImage,
//         ),
//         child: CircleAvatar(
//           radius: 50,
//           backgroundColor: AppColorConstants.mainThemeColor.withOpacity(0.6),
//           backgroundImage: profielImage != null
//               ? FileImage(profielImage!)
//               : null,
//         ),
//       ),
//       Positioned(
//         bottom: 0,
//         right: 0,
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: AppColorConstants.teal, // Customize the color as needed
//           ),
//           child: IconButton(
//             icon: Icon(
//               Icons.edit,
//               color: AppColorConstants.white, // Customize the color as needed
//             ),
//             onPressed: () => UtilityComponents.selectImageSheet(
//               context: context,
//               onTap: pickImage,
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
                    CustomInputFields.inputField(
                        controller: nameController,
                        context: context,
                        hintText: "Enter your name",
                        title: 'Name'),
                    const SizedBox(height: 10),
                    CustomInputFields.inputField(
                        controller: bioController,
                        context: context,
                        hintText: "Enter bio about your self",
                        title: 'Bio'),
                    const SizedBox(height: 10),
                    CustomInputFields.diabledInputField(
                        icon: const Icon(Icons.person),
                        onTap: () {
                          UtilityComponents.selectGendersheet(
                              context: context, controller: genderController);
                        },
                        controller: genderController,
                        context: context,
                        hintText: "Select Gender",
                        title: 'Gender'),
                    const SizedBox(height: 10),
                    CustomInputFields.diabledInputField(
                      icon: const Icon(Icons.edit_calendar_rounded),
                      onTap: () {
                        handleDatePick();
                      },
                      context: context,
                      hintText: dateOfBirth.toString(),
                      title: 'Birth day',
                    ),
                    const SizedBox(height: 10),
                    CustomInputFields.diabledInputField(
                        icon: const Icon(Icons.location_city_rounded),
                        onTap: () {
                          handlePermission();
                        },
                        // icon: const Icon(Ionicons.locate),
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
                        onTap: _handleInfoSubmit,
                        bgColor: AppColorConstants.teal,
                        padding: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            state is ProfileLoading
                                ? const CircularProgressIndicator()
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
          ),
        );
      },
    );
  }

  void _handleInfoSubmit() {
    BlocProvider.of<ProfileBloc>(context).add(ProfileUpdateEvent(
        bannerImage: bannerImage,
        profileImage: profielImage,
        userModel: UserModel(
          bio: bioController.text,
          birthdate: dateOfBirth,
          email: emailController.text,
          geoPoint: locationInfo?.geoPoint,
          phoneNumber: mobileController.text,
          fullName: nameController.text,
          userId: FirebaseAuth.instance.currentUser!.uid,
          username: nameController.text,
        )));
  }

  @override
  void detach() {
    print("profile ditached");
  }

  @override
  bool get keptAlive => true;
}
