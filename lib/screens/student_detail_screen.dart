
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sinh viên'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: student.avatar != null &&
                    student.avatar!.isNotEmpty &&
                    File(student.avatar!).existsSync()
                    ? FileImage(File(student.avatar!))
                    : null,
                child: student.avatar == null ||
                    student.avatar!.isEmpty ||
                    !File(student.avatar!).existsSync()
                    ? const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.blue,
                )
                    : null,
              ),
              const SizedBox(height: 24),
              Text(
                student.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'MSSV: ${student.studentId}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Text(
                'Email: ${student.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
