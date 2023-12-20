import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mikan/controller/books_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'books_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('BooksController', () {
    const String apiKey =
        'AIzaSyC02xX_6NJUUsqlcHBfzSVNIKVfv8hfeXM'; // Replace with your actual API key

    test('fetchBooks updates books on successful API call', () async {
      final client = MockClient();
      final controller = BooksController(apiKey);
      controller.query.value = 'testQuery';

      final fakeUri = Uri.https('www.googleapis.com', '/books/v1/volumes',
          {'q': 'testQuery', 'key': apiKey});

      // Mock a response with actual book data
      final mockResponse = '''
    {
      "items": [
        {
          "volumeInfo": {
            "title": "Sample Book",
            "authors": ["Author Name"],
            "imageLinks": {"thumbnail": "https://example.com/thumbnail.jpg"},
            "infoLink": "https://example.com/book-info"
          }
        }
      ]
    }
  ''';

      when(client.get(fakeUri, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      controller.httpClient = client;
      await controller.fetchBooks();

      // Verify that books list is updated
      expect(controller.books.length, 1);

      // Verify the details of the first book
      final book = controller.books[0];
      expect(book.title, 'Sample Book');
      expect(book.author, 'Author Name');
      expect(book.imageUrl, 'https://example.com/thumbnail.jpg');
      expect(book.url, 'https://example.com/book-info');
    });

    test('fetchBooks throws exception on error', () async {
      final client = MockClient();
      final controller = BooksController(apiKey);
      controller.query.value = 'testQuery';

      final fakeUri = Uri.https('www.googleapis.com', '/books/v1/volumes',
          {'q': 'testQuery', 'key': apiKey});

      when(client.get(fakeUri, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error occurred', 404));

      controller.httpClient = client;

      // Use expectLater to catch the thrown exception
      await expectLater(
        () => controller.fetchBooks(),
        throwsA(isA<Exception>()),
      );

      // Verify that books list is not updated (remains empty)
      expect(controller.books.length, 0);
    });
  });
}
