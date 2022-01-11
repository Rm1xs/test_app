import 'dart:convert';

import 'package:test_app/features/filters/domain/entities/filters.dart';
import 'package:http/http.dart' as http;
import 'filters_remote_data_source.dart';

class FiltersRemoteDataSourceImpl implements FiltersRemoteDataSource {
  final http.Client client;

  FiltersRemoteDataSourceImpl(this.client);

  @override
  Future<Filters> getFilters() async {
    Uri url = Uri.parse(
        'http://filehost.feelsoftware.com/jsonplaceholder/cars-api.php');
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var a = Filters.fromJson(json.decode(response.body));
      return a;
    } else {
      throw Exception();
    }
  }
}
