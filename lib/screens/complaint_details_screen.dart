import 'package:flutter/material.dart';
import '../models/complaint.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  final Complaint complaint;

  const ComplaintDetailsScreen({Key? key, required this.complaint}) : super(key: key);

  @override
  State<ComplaintDetailsScreen> createState() => _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  late String _currentDescription;
  late String _selectedStatus;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentDescription = widget.complaint.description;
    _selectedStatus = widget.complaint.status;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showEditDescriptionDialog() {
    TextEditingController editController = TextEditingController(text: _currentDescription);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Description'),
          content: TextField(
            controller: editController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter new description...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF147A73)),
              onPressed: () {
                setState(() {
                  _currentDescription = editController.text;
                  widget.complaint.description = editController.text; 
                });
                Navigator.pop(context); 
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Center(
            child: Text('Delete Complaint?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          content: const Text(
            'Are you sure you want to permanently delete this complaint?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.teal.shade700),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.teal.shade700)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog box
                Navigator.pop(context, 'delete'); // SEND 'delete' SIGNAL TO DASHBOARD!
              },
              child: const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _saveUpdates() {
    widget.complaint.status = _selectedStatus;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Status updated!'),
        backgroundColor: Color(0xFF147A73),
        duration: Duration(seconds: 1),
      ),
    );

    Navigator.pop(context, 'refresh'); // SEND 'refresh' SIGNAL TO DASHBOARD
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147A73),
        title: const Text('Complaint Details', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), 
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Status  ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(widget.complaint.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.complaint.status,
                    style: TextStyle(
                      color: _getStatusTextColor(widget.complaint.status), 
                      fontWeight: FontWeight.bold, 
                      fontSize: 12
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(
              _currentDescription, 
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 6),
            Text(widget.complaint.timeAgo, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF147A73),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _showEditDescriptionDialog,
                child: const Text('Edit Description', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF147A73),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _saveUpdates, 
                child: const Text('Update Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _interactiveStatusBadge('Pending', Colors.amber.shade100, Colors.amber.shade900),
                _interactiveStatusBadge('In Progress', const Color(0xFFE0F2F1), const Color(0xFF147A73)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _interactiveStatusBadge('Resolved', Colors.green.shade100, Colors.green.shade800),
                _interactiveStatusBadge('Re-open', Colors.grey.shade200, Colors.grey.shade800),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text('Update Comment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Update comment',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal.shade700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _interactiveStatusBadge(String text, Color activeBgColor, Color activeTextColor) {
    bool isSelected = _selectedStatus == text;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedStatus = text;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? activeBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? activeTextColor.withOpacity(0.5) : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? activeTextColor : Colors.grey.shade500, 
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending': return Colors.amber.shade100;
      case 'In Progress': return const Color(0xFFE0F2F1);
      case 'Resolved': return Colors.green.shade100;
      default: return Colors.grey.shade200;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pending': return Colors.amber.shade900;
      case 'In Progress': return const Color(0xFF147A73);
      case 'Resolved': return Colors.green.shade800;
      default: return Colors.grey.shade800;
    }
  }
}