import 'package:flutter/material.dart';
import 'package:flutteraula02/components/difficulty.dart';
import 'package:flutteraula02/data/task_dao.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  const Task(this.nome, this.foto, this.dificuldade, {super.key});

  @override
  State<Task> createState() => _State();
}

@override
class _State extends State<Task> {
  int nivel = 0;

  // Função para verificar se a imagem é da web ou dos assets
  bool assetOrNetwork() {
    return !widget.foto.contains('http');
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Exclui a tarefa ao arrastar
        TaskDao().delete(widget.nome);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tarefa "${widget.nome}" excluída')),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.indigo,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: assetOrNetwork()
                      ? Image.asset(
                    widget.foto,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    widget.foto,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  widget.nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Difficulty(
                  dificultyLevel: widget.dificuldade,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  onPressed: () {
                    TaskDao().delete(widget.nome); // função de exclusão
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (widget.dificuldade > 0)
                            ? (nivel / widget.dificuldade) / 10
                            : 1,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Nível: $nivel',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
