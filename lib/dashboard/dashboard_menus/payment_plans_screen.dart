import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import '../../bottom_app_bar/bottom_app_bar.dart';
import '../../controllers/get_payment_plans_controller.dart';

class PaymentPlanScreen extends StatefulWidget {
  const PaymentPlanScreen({super.key});

  @override
  State<PaymentPlanScreen> createState() => _PaymentPlanScreenState();
}

class _PaymentPlanScreenState extends State<PaymentPlanScreen> {
  final PaymentPlanController controller = Get.put(PaymentPlanController());

  @override
  void initState() {
    super.initState();

    controller.loadBranches();
  }

  @override
  void dispose() {
    controller.selectedBranchName("All");
    controller.selectedBranchCode("");
    controller.plansWithNames.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainWrapper());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        body: Obx(() {
          return Stack(
            children: [

              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.appColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainWrapper()),
                                  );
                                },
                              ),
                            ),
                            Text(
                              "Payment Plan",
                              style: TextStyle(
                                color: AppColors.whiteBg,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: controller.selectedBranchName.value,

                            isExpanded: true,
                            underline: SizedBox(),
                            items: [
                              const DropdownMenuItem<String>(
                                value: "All",
                                child: Text("All"),
                              ),
                              ...controller.branchList
                                  .where((branch) => branch.brnName != "All")
                                  .map<DropdownMenuItem<String>>((branch) {
                                return DropdownMenuItem<String>(
                                  value: branch.brnName,
                                  child: Text(branch.brnName),
                                );
                              }).toList(),
                            ],

                            onChanged: (value) {
                              if (value != null) {
                                controller.changeBranch(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: controller.plansWithNames.isEmpty
                        ? Center(child: Text("No payment plan found"))
                        : ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: controller.plansWithNames.length,
                      itemBuilder: (context, index) {
                        final plan = controller.plansWithNames[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plan["plan_name"]!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: plan["image_url"]!,
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  placeholder: (context, url) => Container(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    color: Colors.grey[200],
                                    child: Center(child:  SpinKitCircle(color: AppColors.appColor, size: 50.0),),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    color: Colors.grey[200],
                                    child: Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              if (controller.isLoading.value && !controller.areImagesLoaded.value)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitCircle(color: AppColors.appColor, size: 50.0),
                        SizedBox(height: 10),
                        Text('Loading...',
                            style: TextStyle(color: AppColors.appColor, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}