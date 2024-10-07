import 'package:flutter/material.dart';
import 'package:flutteraula02/screens/user_profile_screen.dart';
import '../components/news_card.dart';
import '../data/theme_provider.dart';
import 'gadgets_screen.dart';
import 'news_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);

    final List<Map<String, String>> news = [
      {
        'title': 'Apple Lança iPhone 15 com Novo Design',
        'description': 'O novo iPhone 15 foi apresentado pela Apple, trazendo um design renovado e melhorias de desempenho.',
        'details': 'O iPhone 15 apresenta um design totalmente novo, com bordas mais finas e um acabamento em vidro. Além disso, melhorias no desempenho foram feitas com o novo chip A16 Bionic, que promete maior eficiência e velocidade. A Apple também introduziu novas funcionalidades de câmera e melhorias na duração da bateria, tornando o iPhone 15 uma das melhores opções no mercado de smartphones.'
      },
      {
        'title': 'Google Apresenta Atualizações para o Android 14',
        'description': 'A Google revelou novas funcionalidades do Android 14, focando em maior personalização e segurança para os usuários.',
        'details': 'O Android 14 traz um foco renovado em personalização, permitindo que os usuários ajustem ainda mais a aparência do sistema. Além disso, melhorias significativas em termos de segurança foram implementadas, garantindo que os dados dos usuários estejam sempre protegidos. Recursos como uma nova interface de usuário e otimizações de desempenho também foram incluídos.'
      },
      {
        'title': 'Tesla Lança Novo Modelo de Carro Elétrico',
        'description': 'A Tesla lançou seu mais novo modelo de carro elétrico, prometendo uma autonomia de até 600 km com uma única carga.',
        'details': 'O novo modelo da Tesla combina tecnologia avançada com sustentabilidade, oferecendo uma autonomia impressionante de até 600 km com uma única carga. O design moderno e as funcionalidades inteligentes tornam este carro uma escolha popular entre os amantes de veículos elétricos. A Tesla também implementou novas funcionalidades de direção autônoma, tornando a experiência de dirigir ainda mais segura.'
      },
      {
        'title': 'Microsoft Anuncia Nova Versão do Windows',
        'description': 'A Microsoft anunciou a nova versão do Windows, que traz recursos avançados de IA e melhorias no gerenciamento de janelas.',
        'details': 'A nova versão do Windows promete revolucionar a forma como os usuários interagem com seus dispositivos. Com recursos avançados de inteligência artificial, o sistema é capaz de aprender com os hábitos dos usuários e oferecer sugestões personalizadas. Além disso, melhorias significativas no gerenciamento de janelas tornam a multitarefa mais eficiente.'
      },
      {
        'title': 'Meta Revela Novos Recursos para o Facebook',
        'description': 'A Meta revelou novos recursos para o Facebook, incluindo melhorias na proteção de privacidade e interações em grupos.',
        'details': 'Os novos recursos introduzidos pela Meta no Facebook têm como objetivo melhorar a experiência do usuário, com foco em privacidade e interações em grupos. Novas configurações de privacidade permitem que os usuários tenham mais controle sobre suas informações, enquanto melhorias nas interações em grupos tornam a plataforma mais dinâmica e envolvente.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Tecnologia Hoje'),
        backgroundColor: theme?.themeColor ?? Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return NewsCard(
            title: news[index]['title']!,
            description: news[index]['description']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailsScreen(
                    title: news[index]['title']!,
                    description: news[index]['details']!,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GadgetsScreen()),
          );
        },
        child: Icon(Icons.devices),
        backgroundColor: theme?.themeColor ?? Colors.blueGrey,
      ),
    );
  }
}