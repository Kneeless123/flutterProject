import 'package:flutter/material.dart';
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
  List<Complaint> complaints = [
    Complaint(
      id: '1',
      room: '302',
      block: 'Block A',
      title: 'AC leaking water',
      description: 'Water dripping from unit since last night. Water dripping from unit since last night.',
      category: 'Electrical/Plumbing',
      timeAgo: '2 hours ago',
      status: 'Pending',
    ),
    Complaint(
      id: '2',
      room: 'Geyser',
      block: 'Block B',
      title: 'Geyser not heating',
      description: 'Geyser B: Geyser not heating. This is heating from last night.',
      category: 'Electrical/Plumbing',
      timeAgo: '2 hours ago',
      status: 'In Progress',
    ),
    Complaint(
      id: '3',
      room: '105',
      block: 'Block A',
      title: 'Internet down',
      description: 'Internet down complaints are. Internet down. Tait sas ham.',
      category: 'Technical/WiFi',
      timeAgo: '2 hours ago',
      status: 'Resolved',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147A73),
        title: const Text('Hostel Complain System', style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.menu, color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
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
              
              // --- DELETION LOGIC ADDED HERE ---
              if (result == 'delete') {
                setState(() {
                  complaints.removeAt(index); // Actually remove it from the list!
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Complaint Deleted Successfully!'),
                    backgroundColor: Color(0xFFD32F2F), // Red color for delete
                  ),
                );
              } 
              // --- REFRESH LOGIC FOR STATUS UPDATES ---
              else if (result == 'refresh') {
                setState(() {}); 
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Complaint Registered Successfully!'),
                backgroundColor: Color(0xFF147A73),
              ),
            );
          }
        },
      ),
    );
  }
}