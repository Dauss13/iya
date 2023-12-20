/*import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/DatabaseCotroller.dart';

void main() {
  group('DatabaseController Tests', () {
    late DatabaseController databaseController;

    setUp(() {
      // Ensure Flutter is initialized before the test
      TestWidgetsFlutterBinding.ensureInitialized();

      // Set up the Appwrite client for testing
      databaseController = DatabaseController();
      databaseController.client.setEndpoint('https://cloud.appwrite.io/v1');
      databaseController.client.setProject('6566852fe932a7ab011a');
      databaseController.client.setSelfSigned(status: true);

      // Initialize GetX bindings
      Get.testMode = true;
    });

    test('Get Books from Appwrite', () async {
      await databaseController.getBooksFromAppwrite();

      // Expect that the list of created books is not null
      expect(databaseController.create, isNotNull);

      // Add your assertions based on the expected behavior
      expect(databaseController.create.length, greaterThanOrEqualTo(0));
    });

    test('Create Book', () async {
      await databaseController.createBook(
        title: 'Test Book',
        author: 'Test Author',
        price: 10.99,
      );

      // Expect that the list of created books is not null
      expect(databaseController.create, isNotNull);

      // Add your assertions based on the expected behavior
    });

    test('Edit Book', () async {
      // Assuming you have at least one book in the database
      final documentId =
          '6581ca4744accfca4b69'; // Replace with a valid document ID

      await databaseController.editBook(
        documentId: documentId,
        title: 'Updated Test Book',
        author: 'Updated Test Author',
        price: 1999,
      );

      // Add your assertions based on the expected behavior
      // You might want to fetch the updated book and check its properties
    });

    test('Delete Book', () async {
      // Assuming you have at least one book in the database
      final documentId = '123456'; // Replace with a valid document ID

      await databaseController.deleteBook(documentId);

      // Add your assertions based on the expected behavior
      // You might want to fetch the books after deletion and check the length
    });
  });
}*/

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/DatabaseCotroller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DatabaseController Tests', () {
    late DatabaseController databaseController;

    setUp(() {
      // Ensure Flutter is initialized before the test

      // Set up the Appwrite client for testing
      databaseController = DatabaseController();
      databaseController.client.setEndpoint('https://cloud.appwrite.io/v1');
      databaseController.client.setProject('6566852fe932a7ab011a');
      databaseController.client.setSelfSigned(status: true);

      // Initialize GetX bindings
      Get.testMode = true;
    });

    test('Get Books from Appwrite', () async {
      await databaseController.getBooksFromAppwrite();

      // Add your assertions based on the expected behavior
      expect(databaseController.create.length, greaterThanOrEqualTo(0));
    });

    test('Create Book', () async {
      await databaseController.createBook(
        title: 'Test Book',
        author: 'Test Author',
        price: 10000,
      );

      // Add your assertions based on the expected behavior
      expect(databaseController.create, isNotEmpty);
    });

    test('Edit Book', () async {
      // Assuming you have at least one book in the database
      final documentId =
          '6581ca3232b618c711d8'; // Replace with a valid document ID

      await databaseController.editBook(
        documentId: documentId,
        title: 'Updated Test Book',
        author: 'Updated Test Author',
        price: 1999,
      );

      // Add your assertions based on the expected behavior
      // You might want to fetch the updated book and check its properties
    });

    test('Delete Book', () async {
      // Assuming you have at least one book in the database
      final documentId =
          '6581ca3232b618c711d8'; // Replace with a valid document ID

      await databaseController.deleteBook(documentId);

      // Add your assertions based on the expected behavior
      // You might want to fetch the books after deletion and check the length
    });
  });
}
