import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Add this import
import 'package:washmen/colors.dart';
import 'controllers/get_account_statement_controller.dart';
import 'models/get_statement_model.dart';

class AccountStatementScreen extends StatelessWidget {
  final String registrationNo;
  final String brnCode;
  final String plotType;

  const AccountStatementScreen({
    super.key,
    required this.registrationNo,
    required this.brnCode,
    required this.plotType,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountStatementController(
      registrationNo: registrationNo,
      brnCode: brnCode,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Text(
          "Account Statement",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SpinKitWave(
              color: AppColors.appColor,
              size: 50.0,
            ),
          );
        }

        final contract = controller.contractData.value;
        if (contract == null) {
          return const Center(child: Text("No data available"));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
          child: _buildStatementTable(controller.statementList),
        );
      }),
    );
  }

  Widget _buildStatementTable(List<Statement> statements) {
    final scrollController = ScrollController();

    final group1Statements = statements
        .where((s) => s.grp == '1')
        .toList();

    final group3Statements = statements
        .where((s) => s.grp == '3')
        .toList();

    // Totals
    double totalDue(List<Statement> list) => list.fold(0, (sum, s) => sum + (s.dueAmt ?? 0));
    double totalPaid(List<Statement> list) => list.fold(0, (sum, s) => sum + (s.amtReceived ?? 0));
    double totalOs(List<Statement> list) => list.fold(0, (sum, s) => sum + (s.osAmt ?? 0));
    double totalRebat(List<Statement> list) => list.fold(0, (sum, s) => sum + (s.rebatAmt ?? 0));

    final group1Due = totalDue(group1Statements);
    final group1Paid = totalPaid(group1Statements);
    final group1Os = totalOs(group1Statements);
    final group1Rebat = totalRebat(group1Statements);

    final group3Due = totalDue(group3Statements);
    final group3Paid = totalPaid(group3Statements);
    final group3Os = totalOs(group3Statements);
    final group3Rebat = totalRebat(group3Statements);

    final grandDue = group1Due + group3Due;
    final grandPaid = group1Paid + group3Paid;
    final grandOs = group1Os + group3Os;
    final grandRebat = group1Rebat + group3Rebat;

    // Build header row
    Widget buildHeader() {
      return Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FixedColumnWidth(165),
          1: FixedColumnWidth(70),
          2: FixedColumnWidth(100),
          3: FixedColumnWidth(95),
          4: FixedColumnWidth(95),
          5: FixedColumnWidth(95),
          6: FixedColumnWidth(95),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(color: AppColors.appColor),
            children: [
              Center(child: Padding(padding: EdgeInsets.all(10), child: Text('Payment type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              Center(child: Padding(padding: EdgeInsets.all(10), child: Text('Inst No', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              Center(child: Padding(padding: EdgeInsets.all(10), child: Text('Inst Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.all(10), child: Text('Due Amt', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.all(10), child: Text('Paid Amt', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              // Rebat Amt column moved before OS Amt
              Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.all(10), child: Text('Rebat Amt', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.all(10), child: Text('OS Amt', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
            ],
          ),
        ],
      );
    }

    // Build data rows
    Widget buildData() {
      final group1Table = Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FixedColumnWidth(165),
          1: FixedColumnWidth(70),
          2: FixedColumnWidth(100),
          3: FixedColumnWidth(95),
          4: FixedColumnWidth(95),
          5: FixedColumnWidth(95), // Rebat Amt column
          6: FixedColumnWidth(95), // OS Amt column
        },
        children: [
          ...group1Statements.map(_buildDataRow).toList(),
          _buildTotalRow('Sub Total', group1Due, group1Paid, group1Os, group1Rebat),
        ],
      );


      final group3Title = Table(
        columnWidths: {
          0: FixedColumnWidth(165),
          1: FixedColumnWidth(70),
          2: FixedColumnWidth(100),
          3: FixedColumnWidth(95),
          4: FixedColumnWidth(95),
          5: FixedColumnWidth(95),
          6: FixedColumnWidth(95),
        },
        children: [
          TableRow(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Extra Charges',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.appColor)),
                ),
              ),
              SizedBox(), SizedBox(), SizedBox(), SizedBox(), SizedBox(), SizedBox(),
            ],
          ),
        ],
      );

      // Group 3 data rows with border
      final group3Table = Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FixedColumnWidth(165),
          1: FixedColumnWidth(70),
          2: FixedColumnWidth(100),
          3: FixedColumnWidth(95),
          4: FixedColumnWidth(95),
          5: FixedColumnWidth(95),
          6: FixedColumnWidth(95),
        },
        children: [
          ...group3Statements.map(_buildDataRow).toList(),
          _buildTotalRow('Sub Total', group3Due, group3Paid, group3Os, group3Rebat),
        ],
      );

      // Grand total row
      final grandTotalTable = Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FixedColumnWidth(165),
          1: FixedColumnWidth(70),
          2: FixedColumnWidth(100),
          3: FixedColumnWidth(95),
          4: FixedColumnWidth(95),
          5: FixedColumnWidth(95),
          6: FixedColumnWidth(95),
        },
        children: [
          _buildTotalRow('Grand Total', grandDue, grandPaid, grandOs, grandRebat),
        ],
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (group1Statements.isNotEmpty) group1Table,
          if (group3Statements.isNotEmpty) group3Title,
          if (group3Statements.isNotEmpty) group3Table,
          grandTotalTable,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: 'Reg. No: '),
                      TextSpan(
                        text: registrationNo,
                        style: const TextStyle(
                          color: Colors.blue, // value color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(text: 'Plot Type: '),
                      TextSpan(
                        text: plotType,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),


        // Combine header + data in one horizontal scroll view
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(), // header
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: buildData(), // data
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildDataRow(Statement s) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(s.paymentType),
      ),
      Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text('${s.installmentNo}'))),
      Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatDate(s.dates)))),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(s.dueAmt)))),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(s.amtReceived)))),
      // Rebat Amt column moved before OS Amt
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(s.rebatAmt)))),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(s.osAmt)))),
    ]);
  }

  TableRow _buildTotalRow(String title, double due, double paid, double os, double rebat) {
    return TableRow(children: [
      const SizedBox(),
      const SizedBox(),
      Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)))),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(due),
                  style: const TextStyle(fontWeight: FontWeight.bold)))),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(paid),
                  style: const TextStyle(fontWeight: FontWeight.bold)))),
      // Rebat Amt column moved before OS Amt
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(rebat),
                  style: const TextStyle(fontWeight: FontWeight.bold)))),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_formatCurrency(os),
                  style: const TextStyle(fontWeight: FontWeight.bold)))),
    ]);
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  static String _formatCurrency(double? amount) {
    if (amount == null) return '0';
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }
}