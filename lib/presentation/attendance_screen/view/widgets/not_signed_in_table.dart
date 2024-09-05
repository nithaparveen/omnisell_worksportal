import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/repository/api/attendance_screen/model/not_signed_in_model.dart'
    as not_signed_in;

class TableForNotSignedIN extends StatelessWidget {
  final Size size;
  final List<not_signed_in.Datum> notsignedinData;

  const TableForNotSignedIN({
    super.key,
    required this.size,
    required this.notsignedinData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NOT SIGNED IN",
          style: GLTextStyles.openSans(size: 15, weight: FontWeight.w700),
        ),
        SizedBox(height: size.width * .02),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: size.width,
            child: DataTable(
              showBottomBorder: true,
              columnSpacing: 24,
              headingRowColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 208, 209, 210)),
              dataRowMinHeight: size.width * .075,
              headingRowHeight: size.width * .1,
              dataTextStyle:
                  GLTextStyles.interStyle(size: 12.5, weight: FontWeight.w500),
              columns: [
                DataColumn(
                    label: Text(
                  'NAME',
                  textAlign: TextAlign.center,
                  style: GLTextStyles.cabinStyle(size: 14),
                )),
              ],
              rows: notsignedinData.map((data) {
                return DataRow(
                  cells: [
                    DataCell(Text(data.name ?? '')),
                  ],
                );
              }).toList(),
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: ColorTheme.grey, width: 0.5),
                verticalInside:
                    BorderSide(color: ColorTheme.grey, width: 0.5),
                bottom: BorderSide(color: ColorTheme.grey, width: 1.0),
                top: BorderSide(color: ColorTheme.grey, width: 1.0),
                left: BorderSide(color: ColorTheme.grey, width: 1.0),
                right: BorderSide(color: ColorTheme.grey, width: 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
