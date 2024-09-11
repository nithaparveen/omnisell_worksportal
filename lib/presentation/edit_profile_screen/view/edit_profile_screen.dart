import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

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
            style: GLTextStyles.cabinStyle(size: 20),
          ),
          automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EMPLOYEE DETAILS", style: GLTextStyles.openSans(size: 16)),
              buildDetailSection(),
            ],
          ),
        ));
  }

  Widget buildDetailSection() {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 0.8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(label: 'Name', initialValue: 'NITHA PARVEEN K'),
              Row(
                children: [
                  Expanded(
                      child: buildTextField(
                          label: 'Personal Phone', initialValue: '9656844814')),
                  const SizedBox(width: 16),
                  Expanded(
                      child: buildTextField(
                          label: 'Office Phone', initialValue: '')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: buildTextField(
                          label: 'Personal Email',
                          initialValue: 'parveennitha@gmail.com')),
                  const SizedBox(width: 16),
                  Expanded(
                      child: buildTextField(
                          label: 'Office Email',
                          initialValue: 'nitha@spiderworks.in')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: buildDatePickerField(
                          label: 'Official Date Of Birth',
                          initialValue: '19-03-2003')),
                  const SizedBox(width: 16),
                  Expanded(
                      child: buildDatePickerField(
                          label: 'Celebrated Date',
                          initialValue: '19-03-2003')),
                ],
              ),
              buildDatePickerField(label: 'Marriage Date', initialValue: ''),
              Row(
                children: [
                  Expanded(child: buildTextField(label: 'Current Address')),
                  const SizedBox(width: 16),
                  Expanded(child: buildTextField(label: 'Permanent Address')),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildTextField(label: 'LinkedIn URL')),
                  const SizedBox(width: 16),
                  Expanded(child: buildTextField(label: 'Facebook URL')),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildTextField(label: 'Instagram URL')),
                  const SizedBox(width: 16),
                  Expanded(child: buildTextField(label: 'Blog URL')),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: GLTextStyles.cabinStyle(
                        size: 14,
                        color: const Color(0xff468585),
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: GLTextStyles.cabinStyle(
                        size: 14,
                        color: Colors.white,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget buildDatePickerField({
    required String label,
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          // Implement Date Picker
        },
      ),
    );
  }
}
