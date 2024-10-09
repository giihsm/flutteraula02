import 'package:flutter/material.dart';
import 'package:flutteraula02/screens/ApiScreen.dart';
import 'package:flutteraula02/screens/initial_screen.dart';
import '../data/task_inherited.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Início',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: const Icon(Icons.home, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCardItem(
              context,
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/7893/7893272.png',
              title: 'Tarefas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskInherited(child: const InitialScreen())),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildCardItem(
              context,
              imageUrl: 'https://static.vecteezy.com/system/resources/previews/017/217/991/non_2x/3d-calendar-marked-date-and-time-for-reminder-day-in-purple-background-calendar-with-todo-list-for-schedule-appointment-event-day-holiday-planning-concept-3d-alarm-icon-render-illustration-free-png.png',
              title: 'Feriados',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApiScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, {required String imageUrl, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 200,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
