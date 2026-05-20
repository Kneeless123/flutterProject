import 'package:flutter/material.dart';
import 'Home.dart';

class EditScreen extends StatefulWidget {
  final int index;

  const EditScreen({
    super.key,
    required this.index,
  });

  @override
  State<EditScreen> createState() =>
      _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  late TextEditingController titleController;

  late TextEditingController
      descriptionController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: complaints[widget.index].title,
    );

    descriptionController =
        TextEditingController(
      text:
          complaints[widget.index].description,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Complaint",
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
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              maxLines: 4,

              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

                complaints[widget.index] =
                    Complaint(

                  title:
                      titleController.text,

                  description:
                      descriptionController.text,

                  // OLD STATUS
                  status:
                      complaints[widget.index]
                          .status,

                  // OLD DATE
                  date:
                      complaints[widget.index]
                          .date,
                );

                Navigator.pop(context);
              },

              child: const Text(
                "Update Complaint",
              ),
            ),
          ],
        ),
      ),
    );
  }
}