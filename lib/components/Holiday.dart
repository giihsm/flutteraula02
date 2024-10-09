class Holiday {
  final String name;
  final String date;

  Holiday({
    required this.name,
    required this.date,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      name: json['name'] ?? 'Feriado Desconhecido',
      date: json['date'] ?? 'Data Desconhecida',
    );
  }
}