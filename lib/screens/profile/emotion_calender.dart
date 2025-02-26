import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmotionCalender extends StatefulWidget {
  const EmotionCalender({super.key});

  @override
  State<EmotionCalender> createState() => _EmotionCalenderState();
}

class _EmotionCalenderState extends State<EmotionCalender> {
  late List<Appointment> _appointments = [];

  // Map emotions to colors
  final Map<String, Color> emotionColors = {
    'Happy': Colors.green,
    'Sad': Colors.blue,
    'Angry': Colors.red,
    'Anxiety': Colors.orange,
    'Fear': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    _loadEmotions();
  }

  Future<void> _loadEmotions() async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      // Get emotions for a range of dates
      var startDate = DateTime.now()
          .subtract(const Duration(days: 30)); // Example: last 30 days
      var endDate = DateTime.now(); // Today
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('emotion')
          .where('time', isGreaterThanOrEqualTo: startDate)
          .where('time', isLessThanOrEqualTo: endDate)
          .get();

      // Parse emotion data and create appointments
      List<Appointment> appointments = [];
      for (var doc in querySnapshot.docs) {
        var emotionData = doc.data();
        DateTime dateTime = emotionData['time'].toDate();
        String emotionTitle = emotionData['emotion'];

        // Assign color based on emotion type
        Color color = emotionColors[emotionTitle] ?? Colors.grey;

        appointments.add(Appointment(
          startTime: dateTime,
          endTime: dateTime.add(const Duration(hours: 1)),
          subject: emotionTitle,
          color: color,
        ));
      }

      setState(() {
        _appointments = appointments;
      });
    } catch (e, stackTrace) {
      print('Error loading emotions: $e\n$stackTrace');
      // Handle error here, such as showing a dialog to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Calendar'),
        centerTitle: true,
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: AppointmentDataSource(_appointments),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            navigationDirection: MonthNavigationDirection.vertical),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
