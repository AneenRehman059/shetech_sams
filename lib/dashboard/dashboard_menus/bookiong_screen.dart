import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../colors.dart';
import '../../controllers/get_projects_controller.dart';
import '../../customs/app_bar.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/booking_bg.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Obx(() {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      _buildFieldWithHeader(
                        header: 'Project*',
                        child: DropdownButtonFormField<String>(
                          decoration: _dropdownDecoration('Project'),
                          value: selectedProject,
                          items: bookingController.branches.length > 1
                              ? bookingController.branches.sublist(1).map((branch) {
                            return DropdownMenuItem<String>(
                              value: branch["brn_name"]?.trim(),
                              child: Text(branch["brn_name"]?.trim() ?? ""),
                            );
                          }).toList()
                              : [], // Empty list if there's only 1 item or less
                          onChanged: bookingController.isLoading.value
                              ? null
                              : (value) {
                            setState(() {
                              selectedProject = value;
                              selectedBlock = null;
                            });
                            bookingController.selectBranch(value ?? "");
                          },
                          hint: Text(
                            bookingController.isLoading.value
                                ? "Loading projects..."
                                : "Select Project",
                            style: TextStyle(
                                color: bookingController.isLoading.value
                                    ? Colors.black38
                                    : Colors.black54,
                                fontSize: 14),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          disabledHint: Text(
                            "Loading projects...",
                            style: TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      _buildFieldWithHeader(
                        header: 'Block*',
                        child: DropdownButtonFormField<String>(
                          decoration: _dropdownDecoration('Block'),
                          value: selectedBlock,
                          items: bookingController.blocks.map((block) {
                            return DropdownMenuItem<String>(
                              value: block["block_name"],
                              child: Text(block["block_name"] ?? ""),
                            );
                          }).toList(),
                          onChanged: bookingController.isLoading.value
                              ? null
                              : (value) {
                            setState(() {
                              selectedBlock = value;
                            });
                            bookingController.selectBlock(value ?? "");
                          },
                          hint: Text(
                            bookingController.isLoading.value
                                ? "Select Block"
                                : "Select Block",
                            style: TextStyle(
                                color: bookingController.isLoading.value
                                    ? Colors.black38
                                    : Colors.black54,
                                fontSize: 14),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          disabledHint: Text(
                            "Loading blocks",
                            style: TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),

                      SizedBox(height: 12),
                      _buildFieldWithHeader(
                        header: 'Plot Nature*',
                        child: DropdownButtonFormField<String>(
                          decoration: _dropdownDecoration('Plot Nature'),
                          value: selectedPlotNatureCode,
                          items: bookingController.plotNatures.map((nature) {
                            return DropdownMenuItem<String>(
                              value: nature["plot_nature"],
                              child: Text(nature["plot_nature_desc"] ?? ""),
                            );
                          }).toList(),
                          onChanged: bookingController.isLoading.value
                              ? null
                              : (value) {
                            setState(() {
                              selectedPlotNatureCode = value;
                            });
                          },
                          hint: Text(
                            bookingController.isLoading.value
                                ? "Loading plot natures..."
                                : "Select Plot Nature",
                            style: TextStyle(
                                color: bookingController.isLoading.value
                                    ? Colors.black38
                                    : Colors.black54,
                                fontSize: 14),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          disabledHint: Text(
                            "Loading plot natures...",
                            style: TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildFieldWithHeader(
                        header: 'Plot Type *',
                        child: DropdownButtonFormField<String>(
                          decoration: _dropdownDecoration('Plot Type'),
                          value: selectedPlotType,
                          items: bookingController.plotTypes.map((type) {
                            return DropdownMenuItem<String>(
                              value: type["plot_type"],
                              child: Text(type["plot_type_desc"] ?? ""),
                            );
                          }).toList(),
                          onChanged: bookingController.isLoading.value
                              ? null
                              : (value) {
                            setState(() {
                              selectedPlotType = value;
                            });
                          },
                          hint: Text(
                            bookingController.isLoading.value
                                ? "Loading plot types..."
                                : "Select Plot Type",
                            style: TextStyle(
                                color: bookingController.isLoading.value
                                    ? Colors.black38
                                    : Colors.black54,
                                fontSize: 14),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          disabledHint: Text(
                            "Loading plot types...",
                            style: TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildFieldWithHeader(
                        header: 'Plot Size*',
                        child: DropdownButtonFormField<String>(
                          decoration: _dropdownDecoration('Plot Size'),
                          value: selectedPlotSize,
                          items: bookingController.plotSizes.map((plot) {
                            return DropdownMenuItem<String>(
                              value: plot["plot_size_code"],
                              child: Text(plot["plot_size_code"] ?? ""),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPlotSize = value;
                            });
                          },
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          hint: const Text(
                            "Select Plot Size",
                            style: TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),

                      SizedBox(height: 12),
                      _buildFieldWithHeader(
                        controller: plotNoController,
                        header: 'Plot No*',
                        child: _buildTextField('Plot No', plotNoController),
                      ),
                      SizedBox(height: 20),

                      _buildFieldWithHeader(
                        controller: nameController,
                        header: 'Name*',
                        child: _buildTextField('Name', nameController),
                      ),
                      SizedBox(height: 12),

                      _buildFieldWithHeader(
                        controller: cnicController,
                        header: 'CNIC*',
                        child: _buildTextField('CNIC', cnicController,
                            keyboardType: TextInputType.number),
                      ),
                      const SizedBox(height: 12),

                      _buildFieldWithHeader(
                        controller: cityController,
                        header: 'City*',
                        child: _buildTextField('City', cityController,keyboardType: TextInputType.name),
                      ),
                      const SizedBox(height: 12),

                      _buildFieldWithHeader(
                        controller: contactController,
                        header: 'Contact Number*',
                        child: _buildTextField(
                            'Contact No', contactController,
                            keyboardType: TextInputType.phone),
                      ),
                      const SizedBox(height: 12),

                      _buildFieldWithHeader(
                        controller: emailController,
                        header: 'Email',
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null; // Email is optional in your case
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Add Email',
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
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      bookingController.isLoading.value
                          ? Center(
                          child: SpinKitCircle(
                              color: Colors.black87, size: 30))
                          : CustomButton(
                        text: 'Submit',
                        onPressed: _submitForm,
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
                // if (bookingController.isLoading.value)
                //   Center(
                //     child: Container(
                //       padding: EdgeInsets.all(20),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           SpinKitCircle(color: AppColors.appColor, size: 50),
                //           SizedBox(height: 10),
                //           Text(
                //             'Loading',
                //             style: TextStyle(color: AppColors.appColor),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
            );
          }),
        ],
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildFieldWithHeader({
    required String header,
    Widget? child,
    TextEditingController? controller,
    TextInputType? keyboardType,
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
        controller != null
            ? TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Add ${header.replaceAll(' *', '')}',
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
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
          ),
        )
            : child ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Add $label',
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      keyboardType: keyboardType,
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

    print("---- Booking Form Data ----");
    print("Selected Project Name: $selectedProject");
    print("Selected Project Code: ${bookingController.selectedBranchCode.value}");
    print("Selected Block Name: $selectedBlock");
    print("Selected Block Code: ${bookingController.selectedBlockCode.value}");
    print("Selected Plot Size Code: $selectedPlotSize");
    print("Plot No: ${plotNoController.text.trim()}");
    print("Name: ${nameController.text.trim()}");
    print("CNIC: ${cnicController.text.trim()}");
    print("Contact No: ${contactController.text.trim()}");
    print("Email: ${emailController.text.trim()}");
    print("----------------------------");

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