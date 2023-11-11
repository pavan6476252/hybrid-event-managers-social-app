import 'package:flutter/material.dart';
import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/buttons.dart';
import 'package:hybrid/utils/components/components.dart';
import 'package:hybrid/utils/components/input_fields.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/components/background_illustration.dart';

class UserDetailsGatheringScreen extends StatefulWidget {
    static String pathRoute ='/gather-user-details';

  const UserDetailsGatheringScreen({super.key});

  @override
  State<UserDetailsGatheringScreen> createState() =>
      _UserDetailsGatheringScreenState();
}

class _UserDetailsGatheringScreenState
    extends State<UserDetailsGatheringScreen> {
  TextEditingController genderController = TextEditingController();
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(width: 2, color: AppColorConstants.black)),
                  child: const CircleAvatar(radius: 50)),
              CustomInputFields.inputField(
                  context: context, hintText: "Enter your name", title: 'Name'),
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
                  onTap: () {
                    print('get location');
                  },
                  icon: const Icon(Ionicons.locate),
                  context: context,
                  hintText: "Location",
                  title: 'Location'),
              const SizedBox(height: 10),
              CustomInputFields.inputField(
                  context: context,
                  hintText: "Enter your name",
                  title: 'Mobile Number'),
              const SizedBox(height: 20),
              CustomButtons.flatButton(
                  onTap: () {},
                  bgColor: AppColorConstants.teal,
                  padding: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18, color: AppColorConstants.white),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
