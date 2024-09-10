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
    var size = MediaQuery.sizeOf(context);
    final DateFormat timeFormatter = DateFormat('hh:mm aa');
    final DateFormat dateFormatter = DateFormat('dd-MM-yyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: size.width,
            child: DataTable(
              showBottomBorder: true,
              columnSpacing: 24,
              headingRowColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 172, 214, 215)),
              dataRowMinHeight: size.width * .075,
              headingRowHeight: size.width * .1,
              dataTextStyle:
                  GLTextStyles.interStyle(size: 12.5, weight: FontWeight.w500),

              columns: [
                DataColumn(
                    label: Text(
                  'DATE',
                  textAlign: TextAlign.center,
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
            
                return DataRow(
                  cells: [
                    DataCell(Text(createdAt != null ? dateFormatter.format(createdAt) : "")),
                    DataCell(Text(
                        createdAt != null ? timeFormatter.format(createdAt) : "")),
                    DataCell(Text(loggedOutTime != null
                        ? timeFormatter.format(loggedOutTime)
                        : '-')),
                  ],
                );
              }).toList(),
              border: TableBorder(
                horizontalInside:BorderSide(color: ColorTheme.spider, width: 0.5),
                verticalInside: BorderSide(color: ColorTheme.spider, width: 0.5),
                bottom: BorderSide(color: ColorTheme.spider, width: 1.0),
                top: BorderSide(color: ColorTheme.spider, width: 1.0),
                left: BorderSide(color: ColorTheme.spider, width: 1.0),
                right: BorderSide(color: ColorTheme.spider, width: 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
