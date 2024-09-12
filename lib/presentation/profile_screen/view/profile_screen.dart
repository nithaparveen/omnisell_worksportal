import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/profile_screen/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userId});
  final int userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<ProfileController>(context, listen: false)
        .fetchProfileDetails(context, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text(
          "Profile",
          style: GLTextStyles.cabinStyle(size: 22),
        ),
         actions: [
          IconButton(
            onPressed: fetchData,
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
      body: Consumer<ProfileController>(builder: (context, controller, _) {
         if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 46, 146, 157),
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              infoCard(
                "Personal Information",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelValueRow("Name:", controller.profileModel.data?.name ?? ""),
                    labelValueRow("Personal Email:", controller.profileModel.data?.employee?.email ?? ""),
                    labelValueRow("Personal Phone:", controller.profileModel.data?.username ??  ""),
                    labelValueRow("Current Address:", controller.profileModel.data?.employee?.address ??  ""),
                    labelValueRow("Permanent Address:",controller.profileModel.data?.employee?.permanentAddress ??  ""),
                  ],
                ),
              ),
              infoCard(
                "Employment details",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelValueRow("Office Email:", controller.profileModel.data?.email ??  ""),
                    labelValueRow("Office Phone:", controller.profileModel.data?.employee?.phoneNumber ??  ""),
                    labelValueRow("Employee Level:",controller.profileModel.data?.employee?.employeeLevel ??   ""),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget infoCard(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        color: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GLTextStyles.cabinStyle(
                      size: 18, weight: FontWeight.w600)),
              const SizedBox(height: 10),
              content,
            ],
          ),
        ),
      ),
    );
  }

  Widget labelValueRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GLTextStyles.openSans(
                  size: 14, weight: FontWeight.w400, color: Colors.grey)),
           Flexible(
          child: Text(value,
          textAlign: TextAlign.end,
              style: GLTextStyles.openSans(
                  size: 14, weight: FontWeight.w500, color: Colors.black),
              maxLines: 5, 
              overflow: TextOverflow.ellipsis),
        ),
        ],
      ),
    );
  }
}
