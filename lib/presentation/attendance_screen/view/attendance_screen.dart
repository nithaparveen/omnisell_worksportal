import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/controller/attendance_controller.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/view/widgets/attendence_table.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/view/widgets/not_signed_in_table.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  DateTime selectedDate = DateTime.now();

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
    if (tabController.index == 2) {
      // "ALL" tab
      fetchDataForDate(selectedDate);
    }
  }

  void fetchDataForDate(DateTime date) {
    log('Fetching data for date: ${formatDate(date)}');
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final attendanceController =
        Provider.of<AttendanceController>(context, listen: false);
    attendanceController.fetchAttendance(context, formattedDate, formattedDate);
    attendanceController.fetchNotSignedIn(context, formattedDate);
  }

  void fetchDataForTab(int index) {
    if (index == 0) {
      fetchDataForDate(DateTime.now()); // TODAY
    } else if (index == 1) {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      fetchDataForDate(yesterday); // YESTERDAY
    } else if (index == 2) {
      fetchDataForDate(selectedDate); // ALL
    }
  }

  Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    DateTime? selectedDate;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: CalendarDatePicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            onDateChanged: (DateTime date) {
              selectedDate = date;
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    return selectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showCustomDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      _onDateChanged(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (tabController.indexIsChanging) {
          fetchDataForTab(tabController.index);
        }
      });
    fetchDataForTab(tabController.index);
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
              height: size.width*.075,
              width: size.width*.055,
              child: Image.asset("assets/logo-sw.png"),
            ),
            const SizedBox(width: 15),
            Text("Daily Attendance", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              fetchDataForTab(tabController.index);
            },
            tooltip: "Refresh",
            icon: const Icon(
              CupertinoIcons.refresh_circled,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
        bottom: TabBar(
          indicatorColor: Color.fromARGB(255, 46, 146, 157) ,
          controller: tabController,
          labelColor: Colors.black,
          tabs: [
            Tab(child: Text("TODAY", style: GLTextStyles.cabinStyle(size: 12))),
            Tab(
                child: Text("YESTERDAY",
                    style: GLTextStyles.cabinStyle(size: 12))),
            Tab(child: Text("ALL", style: GLTextStyles.cabinStyle(size: 12))),
          ],
          onTap: (index) {
            fetchDataForTab(index);
          },
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 5, top: 5),
        child:
            Consumer<AttendanceController>(builder: (context, controller, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tabController.index == 0) // TODAY tab
                  Text(
                    'Date: ${formatDate(DateTime.now())}',
                    style: GLTextStyles.cabinStyle(size: 16),
                  ),
                if (tabController.index == 1) // YESTERDAY tab
                  Text(
                    'Date: ${formatDate(DateTime.now().subtract(const Duration(days: 1)))}',
                    style: GLTextStyles.cabinStyle(size: 16),
                  ),
                if (tabController.index == 2) // ALL tab
                  Text(
                    'Selected Date: ${formatDate(selectedDate)}',
                    style: GLTextStyles.cabinStyle(size: 16),
                  ),
                if (tabController.index == 2) // ALL tab
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
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Change Date',
                      style: GLTextStyles.cabinStyle(
                        size: 16,
                        color: Colors.white,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(height: size.width*.02),
                controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: Color.fromARGB(255, 46, 146, 157),
                        ),
                      )
                    : controller.attendanceData.isEmpty
                        ? Text(
                            'No one is signed in yet',
                            style: GLTextStyles.cabinStyle(
                                size: 14, color: Colors.grey),
                          )
                        : AttendanceTableRefactored(
                            size: size,
                            attendanceData: controller.attendanceData,
                          ),
                SizedBox(height: size.width * .04),
                if (controller.notSignedInData.isNotEmpty)
                  TableForNotSignedIN(
                    size: size,
                    notsignedinData: controller.notSignedInData,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
