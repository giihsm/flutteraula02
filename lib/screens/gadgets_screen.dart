import 'package:flutter/material.dart';
import '../data/app_data_inherited_widget.dart';

class GadgetsScreen extends StatefulWidget {
  @override
  _GadgetsScreenState createState() => _GadgetsScreenState();
}

class _GadgetsScreenState extends State<GadgetsScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Preencher a lista com gadgets iniciais, se estiver vazia
    final appData = AppDataInheritedWidget.of(context);
    if (appData?.gadgets.isEmpty ?? true) {
      appData?.addGadget('Smartphone');
      appData?.addGadget('Smartwatch');
      appData?.addGadget('Fones de Ouvido Sem Fio');
      appData?.addGadget('Tablet');
      appData?.addGadget('Drone');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = AppDataInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gadgets'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Lista de Gadgets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: appData?.gadgets.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(appData!.gadgets[index]),
                    subtitle: Text('Descrição do ${appData.gadgets[index]}'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Novo Gadget'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        appData?.addGadget(_controller.text);
                      });
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}