// ignore_for_file: lines_longer_than_80_chars, avoid_print, deprecated_member_use

import 'package:http/http.dart' as http;
import 'package:sisal/common/constants.dart';
import 'package:sisal/domain/models/rss_item.dart';
import 'package:xml/xml.dart';

class FeedRepository {
  Future<List<RssItem>> fetchFeed() async {
    final url = Constants.feedUrl;

    try {
      // Effettua la richiesta HTTP
      final response = await http.get(Uri.parse(url));

      // Controlla lo stato della risposta
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);

        // Estrai e mappa gli elementi "item"
        final items = document.findAllElements('item').map((element) {
          // Controlla se ogni elemento esiste prima di accedervi
          final title = element.findElements('title').isNotEmpty
              ? element.findElements('title').single.text
              : 'Titolo non disponibile';
          final description = element.findElements('description').isNotEmpty
              ? element.findElements('description').single.text
              : 'Descrizione non disponibile';
          final link = element.findElements('link').isNotEmpty
              ? element.findElements('link').single.text
              : '';
          final thumbnail = element.findElements('media:thumbnail').isNotEmpty
              ? element.findElements('media:thumbnail').first.getAttribute('url') ?? ''
              : '';

          return RssItem(
            title: title,
            description: description,
            link: link,
            thumbnail: thumbnail,
          );
        }).toList();

        return items;
      } else {
        // Lancia un'eccezione con il codice di stato
        throw Exception('Errore durante il caricamento del feed. HTTP Status: ${response.statusCode}');
      }
    } catch (e) {
      // Log degli errori per debugging
      print('Errore durante il caricamento del feed: $e');
      throw Exception('Impossibile analizzare il feed RSS: $e');
    }
  }
}
