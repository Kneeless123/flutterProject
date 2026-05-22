import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _loadComplaints(); 
  }

  // --- FIX 1: Smarter Loading ---
  Future<void> _loadComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? complaintsJson = prefs.getStringList('saved_complaints');

    // If it is NOT NULL, it means we have saved data before (even if the list is empty because you deleted everything)
    if (complaintsJson != null) {
      setState(() {
        complaints = complaintsJson.map((jsonStr) => Complaint.fromJson(jsonStr)).toList();
        _isLoading = false;
      });
    } else {
      // First time running app EVER: Load dummy data
      setState(() {
        complaints = _getDefaultComplaints();
        _isLoading = false;
      });
      _saveComplaints();
    }
  }

  Future<void> _saveComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> complaintsJson = complaints.map((c) => c.toJson()).toList();
    await prefs.setStringList('saved_complaints', complaintsJson);
  }

  List<Complaint> _getDefaultComplaints() {
    return [
      Complaint(
        id: '1', room: '302', block: 'Block A',
        title: 'AC leaking water',
        description: 'Water dripping from unit since last night.',
        category: 'Electrical', timeAgo: '2 hours ago', status: 'Pending',
      ),
      Complaint(
        id: '2', room: 'Geyser', block: 'Block B',
        title: 'Geyser not heating',
        description: 'Geyser B: Geyser not heating. This is heating from last night.',
        category: 'Electrical', timeAgo: '2 hours ago', status: 'In Progress',
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
                  
                  // If the user hit delete, remove it from the list
                  if (result == 'delete') {
                    setState(() {
                      complaints.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deleted'), backgroundColor: Color(0xFFD32F2F)),
                    );
                  }

                  // --- FIX 2: ALWAYS REFRESH AND SAVE ---
                  // No matter if you edited the description, changed status, or hit the back button...
                  // This ensures the newest changes are immediately saved to your browser/phone memory!
                  setState(() {}); 
                  await _saveComplaints(); 
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
            await _saveComplaints(); // Save immediately after adding
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registered!'), backgroundColor: Color(0xFF147A73)),
            );
          }
        },
      ),
    );
  }
}