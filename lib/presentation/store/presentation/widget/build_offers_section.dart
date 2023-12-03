import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hybrid/presentation/store/domain/model/store_model.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuildStoreOffersSection extends StatefulWidget {
  const BuildStoreOffersSection({super.key, required this.offers});
  final List<Offer> offers;

  @override
  State<BuildStoreOffersSection> createState() =>
      _BuildStoreOffersSectionState();
}

class _BuildStoreOffersSectionState extends State<BuildStoreOffersSection> {
  final PageController _pageController = PageController();
  final int _autoScrollDuration = 5000;
  late Timer _autoScrollTimer;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(
      Duration(milliseconds: _autoScrollDuration),
      (timer) {
        if (_pageController.page == widget.offers.length - 1) {
          _pageController.jumpToPage(0);
        } else {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      },
    );

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: Text('Offers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
            height: 200,
            child: Stack(children: [
              Positioned(
                bottom:10, left: 0,right: 0,
                // alignment: Alignment.bottomCenter,
                child: Center(
                  child: AnimatedSmoothIndicator(
                    count: widget.offers.length,
                    effect: WormEffect(),
                    onDotClicked: (index) {
                      _currentPage = index;
                      setState(() {});
                    },
                    activeIndex: _currentPage,
                  ),
                ),
              ),
              PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.offers.length,
                itemBuilder: (context, index) {
                  final offer = widget.offers[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 15 : 10,
                    ),
                    child: _bannerAddBuilder(context, offer),
                  );
                },
              ),
            ])),
      ],
    );
  }

  _bannerAddBuilder(BuildContext context, Offer offer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  offer.image,
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Banner(
            message: 'Discount ${offer.discountPercentage}%',
            location: BannerLocation.bottomStart,
            color: Colors.teal,
          ),
        ),
        Text(
          offer.description,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
        )
      ],
    );
  }
}
