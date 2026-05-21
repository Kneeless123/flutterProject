import 'package:flutter/material.dart';
import '../models/complaint.dart';

class RegisterComplaintScreen extends StatefulWidget {
  const RegisterComplaintScreen({Key? key}) : super(key: key);

  @override
  State<RegisterComplaintScreen> createState() => _RegisterComplaintScreenState();
}

class _RegisterComplaintScreenState extends State<RegisterComplaintScreen> {
  // I removed the hardcoded text so the fields start empty!
  final _subjectController = TextEditingController();
  final _roomController = TextEditingController();
  final _descriptionController = TextEditingController();
  String selectedCategory = 'Electrical/Plumbing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147A73),
        title: const Text('Register New Complaint', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), 
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Subject'),
            _buildTextField(_subjectController),
            const SizedBox(height: 16),
            _buildLabel('Room/Location'),
            _buildTextField(_roomController),
            const SizedBox(height: 16),
            _buildLabel('Category'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal.shade700),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  items: <String>['Electrical/Plumbing', 'WiFi/Internet', 'Housekeeping']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLabel('Description'),
            _buildTextField(_descriptionController, maxLines: 4),
            const SizedBox(height: 16),
            _buildLabel('Photo/Video'),
            const SizedBox(height: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400, style: BorderStyle.solid),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(80, 80),
              ),
              onPressed: () {},
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image, color: Colors.teal),
                  SizedBox(height: 4),
                  Text('Add Media', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF147A73),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  // 1. Create the object from the typed text
                  Complaint newComplaint = Complaint(
                    id: DateTime.now().toString(), 
                    room: _roomController.text.isEmpty ? 'Unknown' : _roomController.text,
                    block: _roomController.text.isEmpty ? 'Unknown' : _roomController.text, 
                    title: _subjectController.text.isEmpty ? 'No Subject' : _subjectController.text,
                    description: _descriptionController.text.isEmpty ? 'No Description' : _descriptionController.text,
                    category: selectedCategory,
                    timeAgo: 'Just now', // New item will say "Just now"
                    status: 'Pending', 
                  );
                  
                  // 2. Send it back to the home screen
                  Navigator.pop(context, newComplaint);
                },
                child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade700),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF147A73), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}