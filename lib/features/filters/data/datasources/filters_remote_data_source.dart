import 'package:test_app/features/filters/domain/entities/filters.dart';

abstract class FiltersRemoteDataSource {
  Future<Filters> getFilters();
}
