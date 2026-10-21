
class Student {
  final int? id;
  final String name;
  final String studentId;
  final String email;
  final String? avatar;

  Student({
    this.id,
    required this.name,
    required this.studentId,
    required this.email,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'studentId': studentId,
      'email': email,
      'avatar': avatar,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int?,
      name: map['name'] as String,
      studentId: map['studentId'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String?,
    );
  }
}
