import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/DatabaseCotroller.dart';

class EditBookPage extends StatefulWidget {
  final String documentId;
  final String title;
  final String author;
  final int price;

  const EditBookPage({
    Key? key,
    required this.documentId,
    required this.title,
    required this.author,
    required this.price,
  }) : super(key: key);

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  late final DatabaseController _databaseController;
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _databaseController = Get.find();
    _titleController = TextEditingController(text: widget.title);
    _authorController = TextEditingController(text: widget.author);
    _priceController = TextEditingController(text: widget.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Parse the price only if it's not empty
                double parsedPrice = _priceController.text.isNotEmpty
                    ? double.tryParse(_priceController.text) ?? 0.0
                    : widget.price.toDouble();

                // Panggil metode editBook dari DatabaseController
                _databaseController.editBook(
                  documentId: widget.documentId,
                  title: _titleController.text,
                  author: _authorController.text,
                  price: parsedPrice,
                );
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
