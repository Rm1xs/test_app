import 'package:test_app/features/filters/domain/entities/filters.dart';
import 'package:test_app/features/filters/domain/repositories/filters_repository.dart';

class FiltersUseCase {
  final FiltersRepository repository;

  FiltersUseCase(this.repository);

  Future<Filters> getFilters() async {
    return await repository.getFilters();
  }
}
