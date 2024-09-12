import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/app_config/app_config.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/controller/attendance_controller.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/view/widgets/attendence_table.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  int? userId;

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt(AppConfig.userId);
    });
  }

  String formatDate(DateTime? date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return date != null ? formatter.format(date) : 'Select Date';
  }

  void fetchDataForDateRange() {
    if (fromDate != null && toDate != null && userId != null) {
      log('Fetching data for user $userId from ${formatDate(fromDate)} to ${formatDate(toDate)}');
      final String from = DateFormat('yyyy-MM-dd').format(fromDate!);
      final String to = DateFormat('yyyy-MM-dd').format(toDate!);
      final attendanceController =
          Provider.of<AttendanceController>(context, listen: false);
      attendanceController.fetchAttendance(context, from, to, userId);
    } else {
      log('User ID or Date Range is missing');
    }
  }

  Future<void> selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      initialDateRange: fromDate != null && toDate != null
          ? DateTimeRange(start: fromDate!, end: toDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
      fetchDataForDateRange();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: size.width * .075,
              width: size.width * .055,
              child: Image.asset("assets/logo-sw.png"),
            ),
            const SizedBox(width: 15),
            Text("Attendance Report", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: fetchDataForDateRange,
            tooltip: "Refresh",
            icon: const Icon(
              CupertinoIcons.refresh_circled,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        child: Consumer<AttendanceController>(
          builder: (context, controller, _) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff468585),
                      ),
                    ),
                    onPressed: () => selectDateRange(context),
                    child: Text(
                      'Select Date Range',
                      style: GLTextStyles.cabinStyle(
                        size: 16,
                        color: Colors.white,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (fromDate != null && toDate != null)
                    Text(
                      '  from  ${formatDate(fromDate)}  to  ${formatDate(toDate)}',
                      style: GLTextStyles.cabinStyle(size: 16),
                    ),
                  SizedBox(height: size.width * .02),
                  controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: Color.fromARGB(255, 46, 146, 157),
                          ),
                        ) : AttendanceTableRefactored(
                              size: size,
                              attendanceData:
                                  controller.attendanceModel.data ?? [],
                            ),
                  SizedBox(height: size.width * .04),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
