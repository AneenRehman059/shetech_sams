import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washmen/bottom_app_bar/bottom_app_bar.dart';
import '../../colors.dart';
import '../../controllers/get_customer_portal_controller.dart';

class CustomerPortalScreen extends StatefulWidget {
  @override
  State<CustomerPortalScreen> createState() => _CustomerPortalScreenState();
}

class _CustomerPortalScreenState extends State<CustomerPortalScreen> {
  final controller = Get.put(CustomerPortalController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    String formatNumber(String? number) {
      if (number == null || number.isEmpty) return "0";
      try {
        final value = double.tryParse(number) ?? 0;
        final formatter = NumberFormat("#,##0");
        return formatter.format(value);
      } catch (e) {
        return number;
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Portal', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.appColor,
        iconTheme: IconThemeData(color: AppColors.whiteBg),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(MainWrapper());
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWave(
                  color: AppColors.appColor,
                  size: 50.0,
                ),
                Text('Loading',style: TextStyle(color: AppColors.appColor),),
              ],
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Calculate dynamic heights based on available space
            final headerHeight = availableHeight * 0.10;
            final personalInfoHeight = availableHeight * 0.26; // Increased height
            final fileStatusHeight = availableHeight * 0.25;
            final paymentDetailsHeight = availableHeight * 0.26; // Increased height

            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      height: headerHeight,
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),

                    // Personal Info Section
                    Transform.translate(
                      offset: Offset(0, -headerHeight * 0.8),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: personalInfoHeight,
                        decoration: _cardDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionHeader("Personal Info"),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildInfoRow("Name", controller.customerObj.value?.name ?? "", personalInfoHeight),
                                    _buildInfoRow("CNIC", controller.customerObj.value?.cnic ?? "", personalInfoHeight),
                                    _buildInfoRow("Total Files", controller.customerObj.value?.totalFiles.toString() ?? "0", personalInfoHeight),
                                    _buildInfoRow("Address", controller.customerObj.value?.address ?? "", personalInfoHeight),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(0, -headerHeight * 0.5),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: fileStatusHeight,
                        decoration: _whiteCardDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("File Status"),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.02, // 2% of screen width
                                  vertical: MediaQuery.of(context).size.height * 0.01, // 1% of screen height
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    // Calculate item size based on available space
                                    final itemHeight = constraints.maxHeight * 0.4;
                                    final itemWidth = constraints.maxWidth * 0.45;

                                    return GridView.count(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      childAspectRatio: itemWidth / itemHeight,
                                      mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                                      crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                                      children: [
                                        _buildStatusItem("Total", controller.customerObj.value?.total.toString() ?? "0"),
                                        _buildStatusItem("Active", controller.customerObj.value?.active.toString() ?? "0"),
                                        _buildStatusItem("Reserve", controller.customerObj.value?.reserve.toString() ?? "0"),
                                        _buildStatusItem("Canceled", controller.customerObj.value?.canceled.toString() ?? "0"),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(0, -headerHeight * 0.4),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        height: paymentDetailsHeight,
                        decoration: _cardDecoration(color: AppColors.appColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionHeader("Payment Details"),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildPaymentInfoRow("Total Amount", formatNumber(controller.customerObj.value?.totalAmount.toString()), paymentDetailsHeight),
                                    _buildPaymentInfoRow("Total Received", formatNumber(controller.customerObj.value?.totalReceived.toString()), paymentDetailsHeight),
                                    _buildPaymentInfoRow("Total OS", formatNumber(controller.customerObj.value?.totalOS.toString()), paymentDetailsHeight),
                                    _buildPaymentInfoRow("Total OverDue", formatNumber(controller.customerObj.value?.totalOverdue.toString()), paymentDetailsHeight),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }


  Widget _buildInfoRow(String label, String value, double containerHeight) {
    final isAddress = label == "Address";
    final rowHeight = containerHeight * 0.18;

    return SizedBox(
      height: rowHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: rowHeight, // Set fixed height to match row
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.whiteBg,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: isAddress
                    ? SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
                    : Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Updated _buildPaymentInfoRow to accept container height for better sizing
  Widget _buildPaymentInfoRow(String label, String value, double containerHeight) {
    final rowHeight = containerHeight * 0.18; // Calculate row height based on container

    return SizedBox(
      height: rowHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 11, // Reduced font size
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.whiteBg,
              ),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12, // Reduced font size
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ... (Keep all other helper methods the same as in previous version)
  BoxDecoration _cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? AppColors.appColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.whiteBg, strokeAlign: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );
  }

  BoxDecoration _whiteCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.whiteBg, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.appColor.withOpacity(0.8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Reduced font size
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10), // Reduced padding
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Reduced font size
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String value) {
    Color valueColor;
    switch (label) {
      case 'Total': valueColor = Colors.blue[100]!; break;
      case 'Active': valueColor = Colors.green[100]!; break;
      case 'Reserve': valueColor = Colors.orange[100]!; break;
      case 'Canceled': valueColor = Colors.red[100]!; break;
      default: valueColor = Colors.white;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize = constraints.maxWidth * 0.08; // Responsive font size

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Container(
                width: constraints.maxWidth * 0.45, // 45% of available width
                padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.1),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteBg,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.1),
                  decoration: BoxDecoration(
                    color: valueColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize * 1.2, // Slightly larger for values
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}