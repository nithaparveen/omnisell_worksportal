import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';

class TaskDetailBottomSheet extends StatefulWidget {
  final String title;
  final String projectName;
  final String assignedBy;
  final String dueDate;
  String status;
  final Color statusColor;
  final String priority;
  final String reviewer;
  final String description;
  final Function(String, String) onStatusChange;

  TaskDetailBottomSheet({
    super.key,
    required this.title,
    required this.projectName,
    required this.assignedBy,
    required this.dueDate,
    required this.status,
    required this.statusColor,
    required this.priority,
    required this.reviewer,
    required this.description,
    required this.onStatusChange,
  });

  @override
  _TaskDetailBottomSheetState createState() => _TaskDetailBottomSheetState();
}

class _TaskDetailBottomSheetState extends State<TaskDetailBottomSheet> {
  final TextEditingController _remarkController = TextEditingController();

  final Map<String, Color> _statusColors = {
    'Not Started': Colors.grey,
    'In Progress': Colors.blue,
    'Review Pending': Colors.orange,
    'Review Failed': Colors.red,
    'Completed': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Project  ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.projectName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(thickness: 0.25, height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Assigned by",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.assignedBy,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Reviewer",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.reviewer,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Due date",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.dueDate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Priority",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.priority,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String newStatus) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Change status of task",
                                  style: GLTextStyles.cabinStyle(size: 16)),
                              content: SizedBox(
                                width: double
                                    .maxFinite, // Ensures the dialog takes up full width
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Please submit remarks on this task. You can leave it blank if you want.",
                                          style: GLTextStyles.cabinStyle(
                                              size: 14,
                                              weight: FontWeight.w400)),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller: _remarkController,
                                        decoration: const InputDecoration(
                                          hintText: 'Remarks',
                                        ),
                                        maxLines: null, // Allows multiple lines
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.onStatusChange(
                                        newStatus, _remarkController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      itemBuilder: (BuildContext context) {
                        return _statusColors.keys.map((String status) {
                          return PopupMenuItem<String>(
                            value: status,
                            child: Container(
                              margin: const EdgeInsetsDirectional.all(5),
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: _statusColors[status],
                              ),
                              child: Center(
                                child: Text(
                                  status,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList();
                      },
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: widget.statusColor,
                        ),
                        child: Center(
                          child: Text(
                            widget.status,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.description.isNotEmpty) ...[
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
