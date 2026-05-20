import 'package:flutter/material.dart';
import 'Home.dart';

class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  State<AddComplaintScreen> createState() =>
      _AddComplaintScreenState();
}

class _AddComplaintScreenState
    extends State<AddComplaintScreen> {

  TextEditingController titleController =
      TextEditingController();

  TextEditingController descriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Complaint",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: titleController,

              decoration: const InputDecoration(
                labelText: "Complaint Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              maxLines: 4,

              decoration: const InputDecoration(
                labelText:
                    "Complaint Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

                complaints.add(
                  Complaint(
                    title:
                        titleController.text,

                    description:
                        descriptionController
                            .text,

                    status: "Pending",

                    date:
                        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                  ),
                );

                Navigator.pop(context);
              },

              child: const Text(
                "Add Complaint",
              ),
            ),
          ],
        ),
      ),
    );
  }
}