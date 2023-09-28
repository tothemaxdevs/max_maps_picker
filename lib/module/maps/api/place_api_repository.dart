// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:max_maps_picker/module/maps/models/place_search_result/place_search_result.dart';

class PlaceApiRepository {
  final client = Client();

  PlaceApiRepository(this.sessionToken);

  final sessionToken;

  Future<List<PlaceSearchResult>> fetchSuggestions(String input, String lang,
      {required String apiKey}) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?input=$input&types=address&language=$lang&components=country:id&key=$apiKey&sessiontoken=$sessionToken&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&inputtype=textquery';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['results']
            .map<PlaceSearchResult>((p) => PlaceSearchResult.fromJson(p))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
