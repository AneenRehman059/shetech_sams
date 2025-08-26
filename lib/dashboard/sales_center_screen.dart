import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/customs/other_app_bar.dart';

import '../bottom_app_bar/bottom_app_bar.dart';

class SalesCenterScreen extends StatefulWidget {
  final String title;
  const SalesCenterScreen({super.key, required this.title});

  @override
  State<SalesCenterScreen> createState() => _SalesCenterScreenState();
}

class _SalesCenterScreenState extends State<SalesCenterScreen> {
  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF8A2B5B);

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainWrapper());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: OtherAppBar(
          title: 'Sales Center',
          onBackPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => MainWrapper()),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2,
                  width: double.infinity,
                  color: AppColors.appColor,
                ),
                SizedBox(height: 30),
                const Text(
                  'Main Offices',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),

                officeName(title: 'BSM Developers Head Office - \n(LHR)'),
                const SizedBox(height: 15),
                officeBlock(
                  themeColor,
                  address: '56-D Broadway Commercial DHA\nPhase-8 Lahore',
                  phone: '042-111-111-650',
                  email: 'info@newmetrocity.com.pk',
                ),
                const SizedBox(height: 15),

                officeName(title: 'Gwadar Golf City'),
                const SizedBox(height: 15),
                officeBlock(
                  themeColor,
                  address:
                  '320, 3rd Floor Dr.Plaza Near 2 Talwar Clifton\nChowk opp. to Emerald Plaza Karachi',
                  phone: '0800-00101',
                  email: 'info@newmetrocity.com.pk',
                ),
                const SizedBox(height: 15),

                officeName(title: 'New Metro City Sarai Alamgir'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget officeName({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF8A2B5B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/building.png', height: 30, width: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget officeBlock(
      Color themeColor, {
        required String address,
        required String phone,
        required String email,
      }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        border: Border.all(color: themeColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (address.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 25),
                const SizedBox(width: 10),
                Expanded(child: Text(address)),
              ],
            ),
          if (address.isNotEmpty) const SizedBox(height: 15),
          if (phone.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.phone, size: 25),
                const SizedBox(width: 10),
                Text(phone),
              ],
            ),
          if (phone.isNotEmpty) const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.email, size: 25),
              const SizedBox(width: 10),
              Expanded(child: Text(email)),
            ],
          ),
        ],
      ),
    );
  }
}