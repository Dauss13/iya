import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/DatabaseCotroller.dart';
import 'package:mikan/view/pages/AddBooks.dart';
import 'package:mikan/view/pages/EditBooks.dart';
import 'package:mikan/view/widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  late final DatabaseController _databaseController;

  HomePage() {
    _databaseController = Get.put(DatabaseController());
    fetchAppwriteBooks();
  }

  Future<void> fetchAppwriteBooks() async {
    await _databaseController.updateBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Search App'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),

            ),
          ),
          Expanded(
            child: Obx(() {
              final searchResults = _databaseController.create;
              return ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final document = searchResults[index];
                  final title = document.data['Title'];
                  final author = document.data['Author'];
                  final price = (document.data['Price']);

                  return ListTile(
                    title: Text('Title: $title'),
                    subtitle: Text('Author: $author'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Price: $price'),
                        IconButton(
                          onPressed: () async {
                            // Navigasi ke halaman edit dengan membawa data buku
                            await Get.to(() => EditBookPage(
                                  documentId: document.$id,
                                  title: title,
                                  author: author,
                                  price: price,
                                ));
                            await fetchAppwriteBooks();
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () async {
                            // Tambahkan logika untuk aksi ikon sampah di sini
                            await _databaseController.deleteBook(document.$id);
                            await fetchAppwriteBooks();
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Ketika tombol '+' ditekan, buka halaman pembuatan buku
          await Get.to(() => CreateBookPage());
          // Setelah kembali dari CreateBookPage, fetch data kembali
          await fetchAppwriteBooks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
