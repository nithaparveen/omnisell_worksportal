import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/repository/api/attendance_screen/model/attendance_model.dart';

class AttendanceTableRefactored extends StatelessWidget {
  final Size size;
  final List<Datum> attendanceData;

  const AttendanceTableRefactored({
    super.key,
    required this.size,
    required this.attendanceData,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
        DateFormat('HH:mm aa');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24,
            headingRowColor: const MaterialStatePropertyAll(Color.fromARGB(255, 172, 214, 215)),
            dataRowMinHeight: 30,
            headingRowHeight: 40,
            dataTextStyle: GLTextStyles.interStyle(size: 12.5,weight: FontWeight.w500),
            columns: [
              DataColumn(
                  label: Text(
                'NAME',
                style: GLTextStyles.cabinStyle(size: 14),
              )),
              DataColumn(
                  label: Text(
                'SIGN IN',
                style: GLTextStyles.cabinStyle(size: 14),
              )),
              DataColumn(
                  label: Text(
                'SIGN OUT',
                style: GLTextStyles.cabinStyle(size: 14),
              )),
            ],
            rows: attendanceData.map((data) {
              String createdAtStr = data.createdAt?.toString() ?? '';
              String loggedOutTimeStr = data.loggedOutTime?.toString() ?? '';

              DateTime? createdAt;
              DateTime? loggedOutTime;

              if (createdAtStr.isNotEmpty) {
                createdAt = DateTime.parse(createdAtStr).toLocal();
              }

              if (loggedOutTimeStr.isNotEmpty) {
                loggedOutTime = DateTime.parse(loggedOutTimeStr).toLocal();
              }

              return DataRow(cells: [
                DataCell(Text(data.name ?? '')),
                DataCell(
                    Text(createdAt != null ? formatter.format(createdAt) : "")),
                DataCell(Text(loggedOutTime != null
                    ? formatter.format(loggedOutTime)
                    : '-')),
              ]);
            }).toList(),
            border: TableBorder(
              horizontalInside: BorderSide(color: ColorTheme.spider, width: 0.5),
              verticalInside: BorderSide(color: ColorTheme.spider, width: 0.5),
              bottom: BorderSide(color: ColorTheme.spider, width: 1.0),
              top: BorderSide(color: ColorTheme.spider, width: 1.0),
              left: BorderSide(color: ColorTheme.spider, width: 1.0),
              right: BorderSide(color: ColorTheme.spider, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
