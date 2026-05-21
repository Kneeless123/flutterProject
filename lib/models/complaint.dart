import 'dart:convert';

class Complaint {
  final String id;
  final String room;
  final String block;
  final String title;
  String description;
  final String category;
  final String timeAgo;
  String status;

  Complaint({
    required this.id,
    required this.room,
    required this.block,
    required this.title,
    required this.description,
    required this.category,
    required this.timeAgo,
    required this.status,
  });

  // --- ADDED FOR SHARED PREFERENCES ---

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room': room,
      'block': block,
      'title': title,
      'description': description,
      'category': category,
      'timeAgo': timeAgo,
      'status': status,
    };
  }

  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
      id: map['id'] ?? '',
      room: map['room'] ?? '',
      block: map['block'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      timeAgo: map['timeAgo'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Complaint.fromJson(String source) => Complaint.fromMap(json.decode(source));
}