// NotesModel class
class NotesModel {
  final int? id;
  final String title;
  final String message;

  NotesModel({this.id, required this.title, required this.message});

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        message = res['message'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
    };
  }
}