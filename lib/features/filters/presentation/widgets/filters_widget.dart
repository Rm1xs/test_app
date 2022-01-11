import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/text_style.dart';
import 'package:test_app/features/filters/presentation/bloc/filter_cublit.dart';

import '../../../../injection.dart';
import 'filters_component.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String dropdownValue = 'Available';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FilterCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: videoPlayerBackground.withOpacity(0.7)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: DropdownButton<String>(
                alignment: Alignment.center,
                underline: SizedBox.shrink(),
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Available', 'Hidden', 'Disabled']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Container(child: Text(value, style: dropTextStyle,)),
                  );
                }).toList(),
              ),
            ),
          ),
          backgroundColor: appBarColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              color: Colors.blue,

              child: const Text('Hello'),
            ),
          ],
        ),
        body:  SafeArea(
          child: SingleChildScrollView(
            child: Container()//,
          ),
        ),
      ),
    );
  }
}
