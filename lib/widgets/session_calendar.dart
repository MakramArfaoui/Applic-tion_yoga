import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SessionCalendar extends StatefulWidget {
  final List<QueryDocumentSnapshot> sessions;

  const SessionCalendar({
    Key? key,
    required this.sessions,
  }) : super(key: key);

  @override
  State<SessionCalendar> createState() => _SessionCalendarState();
}

class _SessionCalendarState extends State<SessionCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<QueryDocumentSnapshot>> _sessionsByDay;

  @override
  void initState() {
    super.initState();
    _updateSessionsByDay();
  }

  @override
  void didUpdateWidget(SessionCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSessionsByDay();
  }

  void _updateSessionsByDay() {
    _sessionsByDay = {};
    for (var session in widget.sessions) {
      final data = session.data() as Map<String, dynamic>;
      final date = (data['date'] as Timestamp).toDate();
      final day = DateTime(date.year, date.month, date.day);
      _sessionsByDay[day] = [...(_sessionsByDay[day] ?? []), session];
    }
  }

  List<QueryDocumentSnapshot> _getSessionsForDay(DateTime day) {
    return _sessionsByDay[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TableCalendar(
            locale: 'fr_FR',
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: Colors.purple.shade700,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.purple.shade700,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.purple.shade200,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: _getSessionsForDay,
          ),
          const Divider(),
          if (_selectedDay != null) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Séances du ${DateFormat('dd/MM/yyyy').format(_selectedDay!)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._getSessionsForDay(_selectedDay!).map((session) {
                    final data = session.data() as Map<String, dynamic>;
                    final time = DateFormat('HH:mm').format(
                      (data['date'] as Timestamp).toDate(),
                    );
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(data['category']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: _getCategoryColor(data['category']),
                        ),
                      ),
                      title: Text(
                        data['title'] ?? 'Séance de yoga',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${data['category']} • $time • ${data['duration']} min',
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'débutant':
        return Colors.green;
      case 'intermédiaire':
        return Colors.blue;
      case 'avancé':
        return Colors.purple;
      case 'méditation':
        return Colors.deepPurple;
      case 'matinal':
        return Colors.orange;
      case 'prénatal':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}
