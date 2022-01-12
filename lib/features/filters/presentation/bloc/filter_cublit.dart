import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/filters/domain/entities/cars.dart';
import 'package:test_app/features/filters/domain/entities/filters.dart';
import 'package:test_app/features/filters/domain/usecases/filters_usecase.dart';

class FilterCubit extends Cubit<void> {
  FilterCubit(this._filter) : super(null);
  final FiltersUseCase _filter;

  DateTime date = DateTime.now();

  Future<Filters> getFilters() async {
    return await _filter.getFilters();
  }

  int getLength(AsyncSnapshot<Filters> filter, String filterName) {
    if (filter.data!.cars!
            .where((element) => element.state == filterName.toLowerCase())
            .length !=
        0) {
      return filter.data!.cars!
          .where((element) => element.state == filterName.toLowerCase())
          .length;
    } else {
      return filter.data!.cars!.length;
    }
  }

  Iterable<Cars> getElement(AsyncSnapshot<Filters> filter, String filterName) {
    if (filter.data!.cars!
        .where((element) => element.state == filterName.toLowerCase())
        .isNotEmpty) {
      return filter.data!.cars!
          .where((element) => element.state == filterName.toLowerCase());
    } else {
      return filter.data!.cars!;
    }
  }

  saveLastUpdateTime(DateTime lastDate) {
    date = lastDate;
  }

  DateTime getLastUpdateTime() {
    return date;
  }
}
