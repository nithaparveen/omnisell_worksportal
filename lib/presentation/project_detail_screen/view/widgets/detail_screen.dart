import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/global_widget/global_richtext.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/controller/project_detail_controller.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.projectId});
  final int projectId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<ProjectDetailsController>(context, listen: false)
        .fetchDetails(context, widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<ProjectDetailsController>(
        builder: (context, controller, _) {
      final scopeNames = [
        "Website Development",
        "SEO",
        "Influencer Marketing",
        "Paid Ads",
        "Video Shoot",
        "App Development",
        "IT Management",
        "Branding",
        "Social Media Management"
      ];

      final apiScopes = controller.detailsModel.data?.scopes ?? [];

      bool isScopePresent(String scopeName) {
        return apiScopes.any((scope) => scope.scope == scopeName);
      }

      if (controller.isLoading) {
        return  Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
           
              color: ColorTheme.spider,
              size: 30,
            ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 2,
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GLRichText(
                    fontSize: 16,
                    label: "Client",
                    value: controller.detailsModel.data?.account?.accountName ??
                        "",
                  ),
                  SizedBox(height: size.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GLRichText(
                        fontSize: 14,
                        label: "Start Date",
                        value: controller.detailsModel.data?.startDate != null
                            ? DateFormat('dd.MM.yyyy').format(DateTime.parse(
                                "${controller.detailsModel.data!.startDate!}"))
                            : "",
                      ),
                      if (controller.detailsModel.data?.endDate != null)
                        GLRichText(
                          fontSize: 14,
                          label: "End Date",
                          value: controller.detailsModel.data?.endDate != null
                              ? DateFormat('dd.MM.yyyy').format(DateTime.parse(
                                  controller.detailsModel.data!.endDate!))
                              : "",
                        ),
                    ],
                  ),
                  SizedBox(height: size.height * .005),
                  const Divider(thickness: 0.8),
                  const Text(
                    "Scope:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                  Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: scopeNames.map((scopeName) {
                      return ScopeItem(
                        name: scopeName,
                        status: isScopePresent(scopeName),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: size.height * .005),
                  if (controller.detailsModel.data?.country?.name != null) ...[
                    const Divider(thickness: 0.8),
                    GLRichText(
                      label: "Country",
                      value: controller.detailsModel.data?.country?.name ?? "",
                      fontSize: 16,
                    ),
                    SizedBox(height: size.height * .005),
                  ],
                  if (controller.detailsModel.data?.description != null) ...[
                    const Divider(thickness: 0.8),
                    GLRichText(
                      label: "Description",
                      value: controller.detailsModel.data?.description ?? "",
                      fontSize: 16,
                    ),
                  ],
                ],
              )),
        ),
      );
    });
  }
}

class ScopeItem extends StatelessWidget {
  final String name;
  final bool status;

  const ScopeItem({
    super.key,
    required this.name,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          status ? Icons.check_circle : Icons.cancel,
          color: status ? Colors.green : Colors.red,
        ),
        SizedBox(width: size.height * .015),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
