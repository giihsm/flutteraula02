import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/Holiday.dart';
import 'initial_screen.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<Holiday> _holidays = [];
  bool _isLoading = true;
  final String _country = 'BR';
  final String _year = '2024';

  Map<String, String> holidayTranslations = {
    "New Year's Day": "Ano Novo",
    "Carnival": "Carnaval",
    "Good Friday": "Sexta-feira Santa",
    "Easter Sunday": "Domingo de Páscoa",
    "Tiradentes": "Dia de Tiradentes",
    "Labour Day": "Dia do Trabalhador",
    "Corpus Christi": "Corpus Christi",
    "Constitutionalist Revolution of 1932": "Revolução Constitucionalista de 1932",
    "Independence Day": "Dia da Independência",
    "Our Lady of Aparecida": "Nossa Senhora Aparecida",
    "All Souls' Day": "Dia de Finados",
    "Republic Proclamation Day": "Proclamação da República",
    "Black Awareness Day": "Dia da Consciência Negra",
    "Christmas Day": "Natal",
  };

  @override
  void initState() {
    super.initState();
    _fetchHolidays();
  }

  Future<void> _fetchHolidays() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://date.nager.at/Api/v2/PublicHolidays/$_year/$_country'));

    if (response.statusCode == 200) {
      final List<dynamic> holidaysJson = jsonDecode(response.body);
      setState(() {
        _holidays = holidaysJson.map((holiday) => Holiday.fromJson(holiday)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ${response.statusCode}: Erro ao carregar os feriados')),
      );
    }
  }

  // Função para traduzir os nomes dos feriados
  String translateHolidayName(String name) {
    return holidayTranslations[name] ?? name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feriados no Brasil'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _holidays.isNotEmpty
          ? ListView.builder(
        itemCount: _holidays.length,
        itemBuilder: (context, index) {
          final holiday = _holidays[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.deepPurple.shade50,
            child: ListTile(
              title: Text(
                translateHolidayName(holiday.name),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              subtitle: Text(
                holiday.date,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text('Nenhum feriado disponível'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InitialScreen()),
          );
        },
        child: const Icon(Icons.task),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
