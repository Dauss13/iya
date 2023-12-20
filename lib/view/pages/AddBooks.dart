// create_book_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/DatabaseCotroller.dart';
import 'package:mikan/view/widgets/bottom_nav_bar.dart';

class CreateBookPage extends StatelessWidget {
  final DatabaseController _libraryController = Get.put(DatabaseController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _createBook();
              },
              child: Text('Create Book'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void _createBook() async {
    final title = _titleController.text;
    final author = _authorController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (title.isNotEmpty && author.isNotEmpty && price > 0) {
      await _libraryController.createBook(
          title: title, author: author, price: price);
      print('Book created successfully');

      await _libraryController.updateBooks();
      print('Books updated successfully');

      Get.back(); // Navigate back to the home page
    } else {
      Get.snackbar('Error', 'Please fill in all fields',
          backgroundColor: Colors.red);
    }
  }
}
