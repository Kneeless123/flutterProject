import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ComplaintScreen(),
    );
  }
}

class Complaint {
  String title;
  String status;

  Complaint({
    required this.title,
    required this.status,
  });
}

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  List<Complaint> complaints = [];

  void addComplaint(String title, String status) {
    setState(() {
      complaints.add(
        Complaint(title: title, status: status),
      );
    });
  }

  void deleteComplaint(int index) {
    setState(() {
      complaints.removeAt(index);
    });
  }

  void editComplaint(int index, String newTitle, String newStatus) {
    setState(() {
      complaints[index].title = newTitle;
      complaints[index].status = newStatus;
    });
  }

  Color getStatusColor(String status) {
    if (status == "Pending") {
      return Colors.orange;
    } else if (status == "In Progress") {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "Hostel Complaint",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddComplaintPage(),
            ),
          );

          if (result != null) {
            addComplaint(result['title'], result['status']);
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Date Container
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Complaints",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.report_problem,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // List
            Expanded(
              child: complaints.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.inbox,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "No Complaints Added",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(15),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.indigo.shade100,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.indigo,
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Text(
                                        complaints[index].title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(
                                                complaints[index]
                                                    .status)
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        complaints[index].status,
                                        style: TextStyle(
                                          color: getStatusColor(
                                              complaints[index]
                                                  .status),
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const Spacer(),

                                    IconButton(
                                      onPressed: () async {
                                        final result =
                                            await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddComplaintPage(
                                              oldTitle:
                                                  complaints[index]
                                                      .title,
                                              oldStatus:
                                                  complaints[index]
                                                      .status,
                                            ),
                                          ),
                                        );

                                        if (result != null) {
                                          editComplaint(
                                            index,
                                            result['title'],
                                            result['status'],
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        deleteComplaint(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddComplaintPage extends StatefulWidget {
  final String? oldTitle;
  final String? oldStatus;

  const AddComplaintPage({
    super.key,
    this.oldTitle,
    this.oldStatus,
  });

  @override
  State<AddComplaintPage> createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {

  TextEditingController complaintController =
      TextEditingController();

  String selectedStatus = "Pending";

  @override
  void initState() {
    super.initState();

    if (widget.oldTitle != null) {
      complaintController.text = widget.oldTitle!;
    }

    if (widget.oldStatus != null) {
      selectedStatus = widget.oldStatus!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Add Complaint",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),

              child: Column(
                children: [

                  TextField(
                    controller: complaintController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Write Complaint",
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField(
                    value: selectedStatus,
                    items: const [
                      DropdownMenuItem(
                        value: "Pending",
                        child: Text("Pending"),
                      ),
                      DropdownMenuItem(
                        value: "In Progress",
                        child: Text("In Progress"),
                      ),
                      DropdownMenuItem(
                        value: "Done",
                        child: Text("Done"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Select Status",
                      prefixIcon:
                          Icon(Icons.pending_actions),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),

                      onPressed: () {
                        Navigator.pop(
                          context,
                          {
                            "title":
                                complaintController.text,
                            "status": selectedStatus,
                          },
                        );
                      },

                      child: const Text(
                        "Save Complaint",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}