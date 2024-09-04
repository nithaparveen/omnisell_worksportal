import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/controller/attendance_controller.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/view/widgets/attendence_table.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime selectedDate = DateTime.now();

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
    fetchDataForDate(selectedDate);
  }

  void fetchDataForDate(DateTime date) {
    log('Fetching data for date: ${formatDate(date)}');
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final attendanceController = Provider.of<AttendanceController>(context, listen: false);
    attendanceController.fetchAttendance(context, formattedDate, formattedDate);
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
    fetchDataForDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: 30,
              width: 20,
              child: Image.asset("assets/logo-sw.png"),
            ),
            const SizedBox(width: 15),
            Text("Daily Attendance", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
         actions: [
          IconButton(
            onPressed: () {
              fetchDataForDate(selectedDate);
            },
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
        padding: const EdgeInsets.all(15.0),
        child: Consumer<AttendanceController>(builder: (context, controller, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Date: ${formatDate(selectedDate)}',
                  style: GLTextStyles.cabinStyle(size: 18),
                ),
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
                const SizedBox(height: 20),
                controller.isLoading
                    ? const Center(child:  CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: Color.fromARGB(255, 46, 146, 157),
                    ),)
                    : AttendanceTableRefactored(
                        size: size,
                        attendanceData: controller.attendanceData,
                      )
              ],
            ),
          );
        }),
      ),
    );
  }
}
