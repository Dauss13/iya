import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/ClientController.dart';

class DatabaseController extends ClientController {
  late final Databases database;
  RxList<Document> create = <Document>[].obs;

  @override
  void onInit() {
    super.onInit();
    database = Databases(client);
  }

  Future<void> getBooksFromAppwrite() async {
    try {
      final response = await database.listDocuments(
        collectionId:
            "656f5e3db0a86cd093e8", // Ganti dengan ID koleksi Appwrite Anda
        databaseId:
            '656f57894649b811481c', // Ganti dengan ID database Appwrite Anda
      );

      create.assignAll(response.documents);
    } catch (error) {
      print("Error retrieving books: $error");
    }
  }

  Future<void> updateBooks() async {
    await getBooksFromAppwrite();
    update(); // Trigger a rebuild of the widget
  }

  Future<void> createBook({
    required String title,
    required String author,
    required double price,
  }) async {
    try {
      await database.createDocument(
        collectionId:
            "656f5e3db0a86cd093e8", // Ganti dengan ID koleksi Appwrite Anda
        databaseId:
            '656f57894649b811481c', // Ganti dengan ID database Appwrite Anda
        data: {
          'Title': title,
          'Author': author,
          'Price': price,
        },
        documentId: ID.unique(),
      );
      Get.snackbar('Success', 'Book created successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Failed to create book: $error',
          backgroundColor: Colors.red);
    }
  }

// Tambahkan metode editBook pada DatabaseController
  Future<void> editBook({
    required String documentId,
    required String title,
    required String author,
    required double price,
  }) async {
    try {
      await database.updateDocument(
        collectionId: "656f5e3db0a86cd093e8",
        databaseId: '656f57894649b811481c',
        documentId: documentId,
        data: {
          'Title': title,
          'Author': author,
          'Price': price,
        },
      );
      Get.snackbar('Success', 'Book updated successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Failed to update book: $error',
          backgroundColor: Colors.red);
    }
  }

  Future<void> deleteBook(String documentId) async {
    try {
      await database.deleteDocument(
        collectionId: "656f5e3db0a86cd093e8",
        databaseId: '656f57894649b811481c',
        documentId: documentId,
      );
      Get.snackbar('Success', 'Book deleted successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete book: $error',
          backgroundColor: Colors.red);
    }
  }
}
