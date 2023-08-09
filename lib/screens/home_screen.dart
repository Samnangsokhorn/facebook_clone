import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/models/arcticles_model.dart';
import 'package:firebase_learning/services/firebase_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firesbase Learning'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("articles").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            FirebaseSevice firebaseService = FirebaseSevice();
            if (snapshot.hasData) {
              List<Article> articles =
                  firebaseService.getArticles(snapshot.data!.docs);
              return _buildArticles(articles);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              // FirebaseSevice firebaseSevice = FirebaseSevice();
              // firebaseSevice.updateArticle(re, Article(
              //   title:
              // ));
            },
            child: const Icon(Icons.edit_rounded),
          ),
          FloatingActionButton(
            onPressed: () {
              ArticleImage articleImage = ArticleImage(
                  hd: 'https://insomniac.games/wp-content/uploads/2018/09/Spider-Man_PS4_Selfie_Photo_Mode_LEGAL.jpg',
                  sd: 'https://phantom-marca.unidadeditorial.es/e8adfaa8d9ac915c3c9a6703ebbc1ec8/resize/1320/f/jpg/assets/multimedia/imagenes/2023/02/15/16764197331576.jpg');
              Article article = Article(
                  title: 'Spider man',
                  body:
                      'Spider-Man is a superhero appearing in American comic books published by Marvel Comics. Created by writer-editor Stan Lee and artist Steve Ditko',
                  cateid: 'cate01',
                  date: '${DateTime.now()}',
                  image: articleImage);
              FirebaseSevice firebaseSevice = FirebaseSevice();
              firebaseSevice.insertArticle(article);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  _buildArticles(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(articles[index].title.toString()),
            leading: CircleAvatar(             
              radius: 20,
              backgroundImage: NetworkImage(articles[index].image!.hd.toString()),
            )
          ),
        );
      },
    );
  }
}
