import 'package:test_app/features/filters/data/datasources/filters_remote_data_source_implementation.dart';
import 'package:test_app/features/filters/domain/entities/filters.dart';
import 'package:test_app/features/filters/domain/repositories/filters_repository.dart';

class FiltersRepositoryImpl implements FiltersRepository {
  final FiltersRemoteDataSourceImpl remoteDataSourceImpl;

  FiltersRepositoryImpl({required this.remoteDataSourceImpl});

  @override
  Future<Filters> getFilters() async {
    return await remoteDataSourceImpl.getFilters();
  }
}
