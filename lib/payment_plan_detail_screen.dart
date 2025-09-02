import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'colors.dart';
import 'controllers/pay_online_controller.dart';
import 'get_account_statement_screen.dart';
import 'models/client_detail_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PayOnlineScreen extends StatefulWidget {
  final String brnCode;
  final String brnName;
  const PayOnlineScreen({
    super.key,
    required this.brnCode,
    required this.brnName,
  });

  @override
  State<PayOnlineScreen> createState() => _PayOnlineScreenState();
}

class _PayOnlineScreenState extends State<PayOnlineScreen> {
  final _storage = const FlutterSecureStorage();
  String? userId;
  final controller = Get.put(PayOnlineController());

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await _storage.read(key: "user_id");
    if (id != null && id.isNotEmpty) {
      setState(() {
        userId = id;
      });

      controller.fetchClientDetails(
        username: id,
        brnCode: widget.brnCode,
        blockNo: 'a',
        plotNo: '2',
      );
    } else {
      Get.snackbar("Alert", "User ID not found");
    }
  }

  Future<void> _launchYouTubeVideo() async {
    const url = 'https://www.youtube.com/watch?v=vQ1jl64oqT4';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Stack(
            children: [
              Container(
                height: size.height * 0.22,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Pay Online',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitWave(
                      color: AppColors.appColor,
                      size: 50.0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading',
                      style: TextStyle(
                        color: AppColors.appColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        if (controller.clientDetailModel.value == null ||
            controller.clientDetailModel.value!.obj.clientDetailList == null ||
            controller.clientDetailModel.value!.obj.clientDetailList!.isEmpty) {
          return Stack(
            children: [
              Container(
                height: size.height * 0.22,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Pay Online',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }

        final clientDetails = controller.clientDetailModel.value!.obj.clientDetailList!;

        return Stack(
          children: [
            // Fixed Header
            Container(
              height: size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.appColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Pay Online',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Scrollable Content
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.22 - 90), // Adjust this value to match your design
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: clientDetails.length,
                itemBuilder: (context, index) {
                  final client = clientDetails[index];
                  final isFirstItem = index == 0;

                  return Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, isFirstItem ? 1 : 20),
                        child: _buildProfileCard(client),
                      ),
                      Transform.translate(
                        offset: Offset(0, isFirstItem ? 10 : 30),
                        child: _buildInfoCards(client),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(0, isFirstItem ? 20 : 30),
                        child: _buildActionButtons(client),
                      ),
                      Transform.translate(
                        offset: Offset(0, isFirstItem ? 30 : 40),
                        child: _buildVideoPreview(),
                      ),
                      SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileCard(ClientDetail client) => Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.appColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.whiteBg, width: 1),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(width: 10),
            Text(
              client.brnName ?? widget.brnName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.whiteBg,
              ),
            ),
          ],
        ),
        _buildFormRow('Booking ID / Reg#', client.registrationNo ?? ''),
        _buildFormRow('Membership No:', client.Id ?? ''),
        _buildFormRow('Plot / Unit Size:', client.paymentCode ?? ''),
        _buildFormRow('Customer Name:', client.memberName ?? ''),
      ],
    ),
  );

  Widget _buildFormRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.whiteBg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 30,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildInfoCards(ClientDetail client) {
    final asOf = (client.logDate.toString() != '0001-01-01 00:00:00.000')
        ? _fmtDate(client.logDate)
        : '';

    // Calculate the actual amounts
    final totalOutstanding = _calculateTotalOutstanding(client);
    final totalOverDue = _calculateTotalOverDue(client);
    final totalReceived = _calculateTotalReceived(client);

    // Calculate percentages
    final totalReceivedPercent = _calculateTotalReceivedPercent(client, totalReceived);
    final totalOSPercent = _calculateTotalOSPercent(client, totalOutstanding);
    final totalOverDuePercent = _calculateTotalOverDuePercent(client, totalOverDue);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoCard(
            title: 'Total Outstanding',
            amount: 'Rs. ${_formatAmount(totalOutstanding)}/-',
            date: asOf,
            percent: totalOSPercent,
          ),
          const SizedBox(width: 8),
          InfoCard(
            title: 'Total Over Due',
            amount: 'Rs. ${_formatAmount(totalOverDue)}/-',
            date: asOf,
            percent: totalOverDuePercent,
          ),
          const SizedBox(width: 8),
          InfoCard(
            title: 'Total Received',
            amount: 'Rs. ${_formatAmount(totalReceived)}/-',
            date: asOf,
            percent: totalReceivedPercent,
          ),
        ],
      ),
    );
  }

  // Calculate actual amounts
  double _calculateTotalOutstanding(ClientDetail client) {
    try {
      final totDueAmt = double.tryParse(client.totDueAmt) ?? 0;
      final totRecievedAmt = double.tryParse(client.totRecievedAmt) ?? 0;
      final totRebatAmt = double.tryParse(client.totRebatAmt) ?? 0;

      // Formula: tot_due_amt - tot_recieved_amt - tot_rebat_amt
      return totDueAmt - totRecievedAmt - totRebatAmt;
    } catch (e) {
      return 0;
    }
  }

  double _calculateTotalOverDue(ClientDetail client) {
    try {
      // Use the overDueAmount from the model (integer field)
      return client.overDueAmount.toDouble();
    } catch (e) {
      return 0;
    }
  }

  double _calculateTotalReceived(ClientDetail client) {
    try {
      // Use the amountReceived from the model (integer field)
      return client.amountReceived.toDouble();
    } catch (e) {
      return 0;
    }
  }

  // Update percentage calculation methods to use the actual amounts
  int _calculateTotalReceivedPercent(ClientDetail client, double totalReceived) {
    try {
      final netPrice = client.netPrice.toDouble();
      final osAmount = client.osAmount.toDouble();

      if (netPrice + osAmount == 0) return 0;

      final percent = (totalReceived / (netPrice + osAmount)) * 100;
      return percent.round().clamp(0, 100);
    } catch (e) {
      return 0;
    }
  }

  int _calculateTotalOSPercent(ClientDetail client, double totalOutstanding) {
    try {
      final netPrice = client.netPrice.toDouble();

      if (netPrice == 0) return 0;

      final percent = (totalOutstanding / netPrice) * 100;
      return percent.round().clamp(0, 100);
    } catch (e) {
      return 0;
    }
  }

  int _calculateTotalOverDuePercent(ClientDetail client, double totalOverDue) {
    try {
      final dueTillToday = double.tryParse(client.dueTillToday) ?? 0;

      if (dueTillToday == 0) return 0;

      final percent = (totalOverDue / dueTillToday) * 100;
      return percent.round().clamp(0, 100);
    } catch (e) {
      return 0;
    }
  }

  // Format amount with commas for better readability
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  Widget _buildVideoPreview() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GestureDetector(
      onTap: _launchYouTubeVideo,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/bsm_devlopers.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildActionButtons(ClientDetail client) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Expanded(
          child: _buildButton(
            'View Statement',
            onPressed: () {
              Get.to(() => AccountStatementScreen(
                registrationNo: client.registrationNo ?? '',
                brnCode: client.brnCode ?? '',
                plotType: client.plotType ?? 'Normal',
              ));
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildButton(
            'Pay Now',
            onPressed: () {
              // your pay logic here
              print('Pay Now tapped');
            },
          ),
        ),
      ],
    ),
  );

  Widget _buildButton(String text, {VoidCallback? onPressed}) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.appColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(color: AppColors.whiteBg, fontWeight: FontWeight.bold),
      ),
    ),
  );

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _val(dynamic v) {
    if (v == null) return '0';
    if (v is double) return _formatAmount(v);
    return v.toString();
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final int percent;

  const InfoCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentDate =
        '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';

    return Expanded(
      child: Card(
        elevation: 3,
        color: AppColors.appColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
          child: Column(
            children: [
              // Title
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteBg,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: AppColors.appColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Progress bar with percentage
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      value: percent / 100,
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation(AppColors.whiteBg),
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Amount
              Column(
                children: [
                  Text(
                    amount,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.whiteBg, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Divider(color: Colors.white, thickness: 1, height: 20),
                ],
              ),
              Column(
                children: [
                  Text(
                    'As of Day\n$currentDate',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.whiteBg),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}