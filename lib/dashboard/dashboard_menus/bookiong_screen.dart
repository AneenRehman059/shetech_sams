import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:washmen/customs/app_bar.dart';
import '../../colors.dart';
import '../../controllers/get_projects_controller.dart';
import '../../customs/custom_buttons.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedProject;
  String? selectedBlock;
  String? selectedPlotNatureCode;
  String? selectedPlotType;
  String? selectedPlotSize;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController plotNoController = TextEditingController();

  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 8),
                  CustomAppBar(
                    title: 'Booking',
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/booking_bg.png'),
                    opacity: 0.1,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                child: Obx(() {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildFieldWithHeader(
                          header: 'Project*',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                bookingController.isLoading.value
                                    ? "Loading projects..."
                                    : "Select Project",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: bookingController.isLoading.value
                                      ? Colors.black38
                                      : Colors.black54,
                                ),
                              ),
                              items: bookingController.branches.length > 1
                                  ? bookingController.branches.sublist(1).map((branch) {
                                return DropdownMenuItem<String>(
                                  value: branch["brn_name"]?.trim(),
                                  child: Text(
                                    branch["brn_name"]?.trim() ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList()
                                  : [],
                              value: selectedProject,
                              onChanged: bookingController.isLoading.value
                                  ? null
                                  : (value) {
                                setState(() {
                                  selectedProject = value;
                                  selectedBlock = null;
                                });
                                bookingController.selectBranch(value ?? "");
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.appColor,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                offset: const Offset(0, -5),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFieldWithHeader(
                          header: 'Block*',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                bookingController.isLoading.value
                                    ? "Loading blocks..."
                                    : "Select Block",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: bookingController.isLoading.value
                                      ? Colors.black38
                                      : Colors.black54,
                                ),
                              ),
                              items: bookingController.blocks.map((block) {
                                return DropdownMenuItem<String>(
                                  value: block["block_name"],
                                  child: Text(
                                    block["block_name"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedBlock,
                              onChanged: bookingController.isLoading.value
                                  ? null
                                  : (value) {
                                setState(() {
                                  selectedBlock = value;
                                });
                                bookingController.selectBlock(value ?? "");
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.appColor,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                offset: const Offset(0, -5),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildFieldWithHeader(
                          header: 'Plot Nature*',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                bookingController.isLoading.value
                                    ? "Loading plot natures..."
                                    : "Select Plot Nature",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: bookingController.isLoading.value
                                      ? Colors.black38
                                      : Colors.black54,
                                ),
                              ),
                              items: bookingController.plotNatures.map((nature) {
                                return DropdownMenuItem<String>(
                                  value: nature["plot_nature"],
                                  child: Text(
                                    nature["plot_nature_desc"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedPlotNatureCode,
                              onChanged: bookingController.isLoading.value
                                  ? null
                                  : (value) {
                                setState(() {
                                  selectedPlotNatureCode = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.appColor,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                offset: const Offset(0, -5),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildFieldWithHeader(
                          header: 'Plot Type *',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                bookingController.isLoading.value
                                    ? "Loading plot types..."
                                    : "Select Plot Type",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: bookingController.isLoading.value
                                      ? Colors.black38
                                      : Colors.black54,
                                ),
                              ),
                              items: bookingController.plotTypes.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type["plot_type"],
                                  child: Text(
                                    type["plot_type_desc"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedPlotType,
                              onChanged: bookingController.isLoading.value
                                  ? null
                                  : (value) {
                                setState(() {
                                  selectedPlotType = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.appColor,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                offset: const Offset(0, -5),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildFieldWithHeader(
                          header: 'Plot Size*',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Text(
                                "Select Plot Size",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              items: bookingController.plotSizes.map((plot) {
                                return DropdownMenuItem<String>(
                                  value: plot["plot_size_code"],
                                  child: Text(
                                    plot["plot_size_code"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedPlotSize,
                              onChanged: (value) {
                                setState(() {
                                  selectedPlotSize = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.appColor,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                offset: const Offset(0, -5),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildFieldWithHeader(
                          controller: plotNoController,
                          header: 'Plot No*',
                        ),
                        SizedBox(height: 20),
                        _buildFieldWithHeader(
                          controller: nameController,
                          header: 'Name*',
                        ),
                        SizedBox(height: 12),
                        _buildFieldWithHeader(
                          controller: cnicController,
                          header: 'CNIC*',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        _buildFieldWithHeader(
                          controller: cityController,
                          header: 'City*',
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 12),
                        _buildFieldWithHeader(
                          controller: contactController,
                          header: 'Contact Number*',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        _buildFieldWithHeader(
                          controller: emailController,
                          header: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          isEmail: true,
                        ),
                        SizedBox(height: 30),
                        bookingController.isLoading.value
                            ? Center(
                          child: SpinKitCircle(
                            color: Colors.black87,
                            size: 30,
                          ),
                        )
                            : CustomButton(
                          text: 'Submit',
                          onPressed: _submitForm,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldWithHeader({
    required String header,
    TextEditingController? controller,
    TextInputType? keyboardType,
    Widget? child,
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 4),
          child: Text(
            header,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        if (child != null) child,
        if (controller != null)
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: isEmail
                ? (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            }
                : null,
            decoration: InputDecoration(
              hintText: 'Add ${header.replaceAll('*', '').trim()}',
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.appColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.appColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.appColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
      ],
    );
  }

  void _submitForm() {
    // Check required fields
    if (selectedProject == null ||
        selectedBlock == null ||
        selectedPlotType == null ||
        selectedPlotNatureCode == null ||
        selectedPlotSize == null ||
        plotNoController.text.isEmpty ||
        nameController.text.isEmpty ||
        cnicController.text.isEmpty ||
        cityController.text.isEmpty ||
        contactController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields");
      return;
    }

    if (emailController.text.isNotEmpty &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      Get.snackbar("Error", "Please enter a valid email address");
      return;
    }

    bookingController.submitBooking(
      brnCode: bookingController.selectedBranchCode.value,
      idNo: cnicController.text.trim(),
      contactName: nameController.text.trim(),
      contactNo: contactController.text.trim(),
      plotSizeCode: selectedPlotSize ?? "",
      plotNo: plotNoController.text.trim(),
      blockNo: bookingController.selectedBlockCode.value,
      email: emailController.text.trim(),
      plotNature: selectedPlotNatureCode ?? "",
      plotType: selectedPlotType ?? "",
    );
  }
}