import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- Imported SharedPreferences
import '../models/complaint.dart';
import '../widgets/complaint_card.dart';
import 'register_complaint_screen.dart';
import 'complaint_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Complaint> complaints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadComplaints(); // Load data when app starts
  }

  // --- LOAD SAVED DATA ---
  Future<void> _loadComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? complaintsJson = prefs.getStringList('saved_complaints');

    if (complaintsJson != null && complaintsJson.isNotEmpty) {
      // Convert JSON strings back to Complaint objects
      setState(() {
        complaints = complaintsJson.map((jsonStr) => Complaint.fromJson(jsonStr)).toList();
        _isLoading = false;
      });
    } else {
      // First time running app: Load dummy data and save it
      setState(() {
        complaints = _getDefaultComplaints();
        _isLoading = false;
      });
      _saveComplaints();
    }
  }

  // --- SAVE CURRENT DATA ---
  Future<void> _saveComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert Complaint objects to JSON strings
    final List<String> complaintsJson = complaints.map((c) => c.toJson()).toList();
    await prefs.setStringList('saved_complaints', complaintsJson);
  }

  // Dummy data for first-time use
  List<Complaint> _getDefaultComplaints() {
    return [
      Complaint(
        id: '1', room: '302', block: 'Block A',
        title: 'AC leaking water',
        description: 'Water dripping from unit since last night.',
        category: 'Electrical/Plumbing', timeAgo: '2 hours ago', status: 'Pending',
      ),
      Complaint(
        id: '2', room: 'Geyser', block: 'Block B',
        title: 'Geyser not heating',
        description: 'Geyser B: Geyser not heating. This is heating from last night.',
        category: 'Electrical/Plumbing', timeAgo: '2 hours ago', status: 'In Progress',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147A73),
        title: const Text('Hostel Complain System', style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.menu, color: Colors.white),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF147A73)))
        : ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintDetailsScreen(complaint: complaints[index]),
                    ),
                  );
                  
                  if (result == 'delete') {
                    setState(() {
                      complaints.removeAt(index);
                    });
                    await _saveComplaints(); // SAVE AFTER DELETE
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deleted'), backgroundColor: Color(0xFFD32F2F)),
                    );
                  } else if (result == 'refresh') {
                    setState(() {}); 
                    await _saveComplaints(); // SAVE AFTER EDIT/STATUS UPDATE
                  }
                },
                child: ComplaintCard(
                  key: ValueKey('${complaints[index].status}_${complaints[index].description}'),
                  complaint: complaints[index],
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF147A73),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final newComplaint = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterComplaintScreen()),
          );
          
          if (newComplaint != null && newComplaint is Complaint) {
            setState(() {
              complaints.insert(0, newComplaint);
            });
            await _saveComplaints(); // SAVE AFTER ADDING NEW
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registered!'), backgroundColor: Color(0xFF147A73)),
            );
          }
        },
      ),
    );
  }
}