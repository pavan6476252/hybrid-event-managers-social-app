import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid/bloc/auth/auth_bloc.dart';
import 'package:hybrid/bloc/profile/profile_bloc.dart';
import 'package:hybrid/features/auth/user_details_gather.dart';
import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/background_illustration.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final List<Map<String, dynamic>> userPosts = List.generate(
    15,
    (index) => {
      'id': index,
      'imageUrl': 'https://picsum.photos/id/$index/200/300',
      'likes': 0,
      'comments': 0,
    },
  );

  final List<bool> isSelected = [true, false];
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<ProfileBloc>().add();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileBloc>().add(ProfileGetEvent());
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileBloc>().add(ProfileGetEvent());
          }
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileDoesNotExists) {
            return Center(
                  child: TextButton(
                      onPressed: () {
                        context.push(UserDetailsGatheringScreen.pathRoute);
                      },
                      child: Text("Profile doesn't exists Create Now")),
                );
          }
          if (state is ProfileLoaded) {
            return Stack(
              children: [
                BackGroundIllustrations.backGroundIllustration(
                  context: context,
                  bottom: MediaQuery.of(context).size.height / 2,
                  left: -MediaQuery.of(context).size.width / 1.8,
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        profileInfo(context),
                        const SizedBox(height: 20),
                        ToggleButtons(
                          isSelected: isSelected,
                          onPressed: (index) {
                            setState(() {
                              selectedIndex = index;
                              isSelected[index] = true;
                              for (int i = 0; i < isSelected.length; i++) {
                                if (i != index) isSelected[i] = false;
                              }
                            });
                          },
                          selectedColor: Colors.white,
                          fillColor: AppColorConstants.teal,
                          selectedBorderColor: Colors.black,
                          borderColor: Colors.black,
                          borderWidth: 0.2,
                          borderRadius: BorderRadius.circular(15),
                          constraints: BoxConstraints(
                            minHeight: 36,
                            minWidth:
                                (MediaQuery.of(context).size.width - 30) / 2,
                          ),
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: const Text(
                                "Posts",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: const Text(
                                "Products",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildContentView(selectedIndex),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text(state.toString()),
          );
        },
      ),
    );
  }

  Column profileInfo(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(
            'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "John Doe",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        Text(
          "@johnode",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Posts",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "35",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Followers",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "135",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Following",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "89",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentView(int index) {
    if (index == 0) {
      return _buildGridView(userPosts);
    } else {
      return _buildGridView([]);
    }
  }

  _buildGridView(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return const Text("No Data");
    }
    return GridView.custom(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: data.length,
        (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: data[index]['imageUrl'],
          ),
        ),
      ),
    );
  }
}
