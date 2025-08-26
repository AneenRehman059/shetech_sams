import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:washmen/bottom_app_bar/bottom_app_bar.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/customs/other_app_bar.dart';

import '../constants/text_contants.dart';

class AboutUsScreen extends StatefulWidget {
  final String title;
  const AboutUsScreen({super.key, required this.title});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight * 0.6; // 60% of screen height

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainWrapper());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: OtherAppBar(
          title: AppTextContent.aboutUsTitle,
          onBackPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => MainWrapper()),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10),
              Container(
                color: AppColors.appColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 6,
                      ),
                      child: Text(
                        AppTextContent.aboutUsTitle, // Using constant
                        style: TextStyle(
                          color: AppColors.appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTextContent.about, // Using constant
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            AppTextContent.bsmDevelopers, // Using constant
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            AppTextContent.beliefQuote, // Using constant
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            AppTextContent.aboutDescription, // Using constant
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      color: AppColors.whiteBg,
                      child: SizedBox(
                        height: 40,
                        child: Marquee(
                          text: AppTextContent.marqueeText, // Using constant
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.appColor,
                          ),
                          blankSpace: 50.0,
                          velocity: 50.0,
                          pauseAfterRound: Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                height: 150,
                'assets/images/about.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SizedBox(height: 10),

              // Our Journey Section
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          AppTextContent.ourJourneyTitle, // Using constant
                          style: TextStyle(
                            color: AppColors.whiteBg,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 250,
                        child: Text(
                          AppTextContent.ourJourneyDescription, // Using constant
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.appColor,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                height: 200,
                'assets/images/metro.jpg',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),

              // OUR SUCCESS Section
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        AppTextContent.ourSuccessTitle, // Using constant
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 80,right: 20),
                      child: Text(
                        AppTextContent.ourSuccessDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.appColor,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                height: 300,
                                'assets/images/bsm_g.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.appColor.withOpacity(0.9),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "WELCOME TO",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          AppTextContent.city,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Transform.translate(
                            offset: Offset(0, -20),
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(right: 0),
                                decoration: BoxDecoration(
                                  color: AppColors.appColor,
                                ),
                                child: Text(
                                  AppTextContent.ourWelcomeDescription,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTextContent.investingTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        AppTextContent.citys,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        AppTextContent.investingDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: containerHeight, // Using MediaQuery height
                            decoration: BoxDecoration(
                              color: AppColors.b1,
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MISSION',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      "Investing in New Metro City isn't just an opportunity to own a home; it's a path to financial security. With property values on the rise and strategic locations that ensure excellent connectivity, these projects represent a lucrative investment prospect. Whether you're seeking a modern home for your family or looking to diversify your investment portfolio, New Metro City has got you covered.\n\n"
                                          "Join us in shaping the future of urban living at New Metro City. Experience a lifestyle that exceeds expectations, and seize this golden investment opportunity today.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: containerHeight, // Using MediaQuery height
                            decoration: BoxDecoration(
                              color: AppColors.b2,
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VALUES',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      "Guided by the principles of integrity, innovation, and unwavering commitment, we promise to keep our word, fulfil our obligations, and take responsibility for our actions. Our work radiates with positivity, and we're always eager to go the extra mile, aiming to surpass your expectations and achieve remarkable results together.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: containerHeight, // Using MediaQuery height
                            decoration: BoxDecoration(
                              color: AppColors.b3,
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VISION',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      "Striving to reach unparalleled heights within the real estate industry, our vision is to become a premier developer known for crafting impeccably designed, sustainable residential and commercial luxury projects.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      'OUR LEGACY',
                      style: TextStyle(
                          fontSize: 22,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Image.asset(
                        height: 220,
                        'assets/images/ab1.png',
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Image.asset(
                        height: 220,
                        'assets/images/ab2.png',
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Image.asset(
                        height: 220,
                        'assets/images/ab3.png',
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}