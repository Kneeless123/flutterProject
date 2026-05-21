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
}