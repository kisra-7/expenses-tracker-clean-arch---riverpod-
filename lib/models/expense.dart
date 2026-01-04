import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String id;
  String title;
  String description;
  double cost;
  int color;
  DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.cost,
    required this.color,
    required this.date,
  });

  Expense copyWith({
    String? id,
    String? title,
    String? description,
    double? cost,
    int? color,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      color: color ?? this.color,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'cost': cost,
      'color': color,
      'date': date,
    };
  }

  factory Expense.fromFirestore(Map<String, dynamic> data, String documentId) {
    final rawDate = data['date'];

    DateTime parsedDate;
    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate is String) {
      parsedDate = DateTime.parse(rawDate);
    } else {
      parsedDate = DateTime.now();
    }

    return Expense(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      cost: (data['cost'] as num).toDouble(),
      color: data['color'],
      date: parsedDate,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromFirestore(json.decode(source), json.decode(source)['id']);

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, description: $description, cost: $cost, color: $color, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Expense &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.cost == cost &&
        other.color == color &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        cost.hashCode ^
        color.hashCode ^
        date.hashCode;
  }
}
