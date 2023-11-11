import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildTopIllustion(),
        PageView.builder(
            onPageChanged: (value) => setState(() {
                  currentPage = value;
                }),
            controller: _pageController,
            itemCount: AppConstants.onBoardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPage(data: AppConstants.onBoardingData[index]);
            }),
        _buildPageIndicator(),
        _buildBottomNextButton(),
      ],
    ));
  }

  _buildBottomNextButton() {
    return Positioned(
      bottom: -40,
      right: -40,
      child: Transform.rotate(
        angle: 45,
        child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(85),
                border: Border.all(color: AppColorConstants.black)),
            child: Container(
              width: 180,
              height: 206,
              decoration: BoxDecoration(
                  color:
                      AppConstants.onBoardingData.length % (currentPage + 1) ==
                              0
                          ? AppColorConstants.mainThemeColor
                          : AppColorConstants.black,
                  borderRadius: BorderRadius.circular(79)),
              child: Center(
                child: Transform.rotate(
                  angle: -45,
                  child: GestureDetector(
                    onTap: () =>
                        currentPage == AppConstants.onBoardingData.length - 1
                            ? () {}
                            : _pageController.animateToPage(currentPage + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentPage == AppConstants.onBoardingData.length - 1
                              ? "Lets'go"
                              : "Next",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: AppConstants.onBoardingData.length %
                                                (currentPage + 1) ==
                                            0
                                        ? AppColorConstants.black
                                        : AppColorConstants.white,
                                  ),
                        ),
                        const SizedBox(width: 5),
                        currentPage == AppConstants.onBoardingData.length - 1
                            ? const SizedBox.shrink()
                            : Icon(
                                Icons.arrow_forward,
                                color: AppConstants.onBoardingData.length %
                                            (currentPage + 1) ==
                                        0
                                    ? AppColorConstants.black
                                    : AppColorConstants.white,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  _buildTopIllustion() {
    return Positioned(
      top: -120,
      left: -270,
      child: Transform.rotate(
        angle: 45,
        child: Container(
            padding: const EdgeInsets.all(55),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
                border: Border.all(color: AppColorConstants.lightGray)),
            child: Container(
              width: 469,
              height: 680,
              decoration: BoxDecoration(
                  color: AppColorConstants.mainThemeColor,
                  borderRadius: BorderRadius.circular(160)),
            )),
      ),
    );
  }

  _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < AppConstants.onBoardingData.length; i++) {
      indicators.add(Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == currentPage ? AppColorConstants.black : Colors.grey,
          )));
    }

    return Positioned(
      bottom: 200,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...indicators],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnBoardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          data.image,
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 30.0),
        Text(
          data.title,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            data.subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
