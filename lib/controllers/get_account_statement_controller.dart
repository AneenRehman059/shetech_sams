// controllers/get_account_statement_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:washmen/models/get_statement_model.dart';

import '../constants/api_constant.dart';

class AccountStatementController extends GetxController {
  final String registrationNo;
  final String brnCode;

  var isLoading = true.obs;
  var statementList = <Statement>[].obs;
  var contractData = Rxn<ContractData>(); // store main object

  AccountStatementController({
    required this.registrationNo,
    required this.brnCode,
  });

  @override
  void onInit() {
    super.onInit();
    fetchAccountStatement();
  }

  Future<void> fetchAccountStatement() async {
    try {
      isLoading(true);

      final url = Uri.parse(
        "${ApiConstants.getStatementUrl}?reg_no=$registrationNo&brn_code=$brnCode",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final contractResponse = ContractResponse.fromJson(data);

        contractData.value = contractResponse.obj;
        statementList.value = contractResponse.obj.statementList;
      } else {
        print("Error fetching statement: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Error fetching account statement: $e");
    } finally {
      isLoading(false);
    }
  }
}
