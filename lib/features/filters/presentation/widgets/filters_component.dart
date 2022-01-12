import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/text_style.dart';
import 'package:test_app/features/filters/domain/entities/cars.dart';
import 'package:test_app/features/filters/domain/entities/filters.dart';
import 'package:test_app/features/filters/presentation/bloc/filter_cublit.dart';

import '../../../../injection.dart';

class FilterComponent extends StatefulWidget {
  FilterComponent({Key? key, required this.filterName}) : super(key: key);

  String filterName;

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  late Future<Filters> data;
  Timer? timer;

  DateTime dt = DateTime.parse('2020-01-02 03:04:05');

  @override
  void initState() {
    data = sl<FilterCubit>().getFilters();
    timer =
        Timer.periodic(const Duration(seconds: 10), (Timer t) => updateList());
    super.initState();
  }

  void updateList() {
    setState(() {
      data = sl<FilterCubit>().getFilters();

      //Data from API updated %d seconds ago...
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Filters>(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<Filters> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount:
                    sl<FilterCubit>().getLength(snapshot, widget.filterName),
                itemBuilder: (context, index) {
                  var elem =
                      sl<FilterCubit>().getElement(snapshot, widget.filterName);
                  Cars cars = elem.elementAt(index);
                  DateTime dt = DateTime.parse(cars.date!.toString());
                  return Column(
                    children: <Widget>[
                      if (cars.state == 'available')
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.02,
                              MediaQuery.of(context).size.height * 0.01,
                              MediaQuery.of(context).size.width * 0.02,
                              MediaQuery.of(context).size.height * 0.01),
                          child: InkWell(
                            onTap: () => {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: Text(
                                        cars.number.toString(),
                                        style: numberTextStyle,
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'Status: ' +
                                                      cars.state.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: appBarVideoPlayer),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  dt.hour.toString() +
                                                      ':' +
                                                      dt.minute.toString() +
                                                      ':' +
                                                      dt.second.toString() +
                                                      ',' +
                                                      dt.day.toString() +
                                                      '.' +
                                                      dt.month.toString() +
                                                      '.' +
                                                      dt.year.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: appBarVideoPlayer),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () => {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop()
                                                },
                                            child: Text(
                                              'Close',
                                              style: TextStyle(
                                                  color: appBarVideoPlayer),
                                            ))
                                      ],
                                    );
                                  })
                            },
                            child: Container(
                              color: greenColor,
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    cars.number.toString(),
                                    style: numberTextStyle,
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        dt.hour.toString() +
                                            ':' +
                                            dt.minute.toString() +
                                            ':' +
                                            dt.second.toString() +
                                            ',' +
                                            dt.day.toString() +
                                            '.' +
                                            dt.month.toString() +
                                            '.' +
                                            dt.year.toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (cars.state == 'hidden')
                        InkWell(
                          onTap: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text(
                                      cars.number.toString(),
                                      style: numberTextStyle,
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                'Status: ' +
                                                    cars.state.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: appBarVideoPlayer),
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                dt.hour.toString() +
                                                    ':' +
                                                    dt.minute.toString() +
                                                    ':' +
                                                    dt.second.toString() +
                                                    ',' +
                                                    dt.day.toString() +
                                                    '.' +
                                                    dt.month.toString() +
                                                    '.' +
                                                    dt.year.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: appBarVideoPlayer),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () => {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop()
                                              },
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                                color: appBarVideoPlayer),
                                          ))
                                    ],
                                  );
                                })
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.01,
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.01),
                            child: Container(
                              color: videoPlayerBackground,
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    cars.number.toString(),
                                    style: numberTextStyle,
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: Text(
                                      dt.hour.toString() +
                                          ':' +
                                          dt.minute.toString() +
                                          ':' +
                                          dt.second.toString() +
                                          ',' +
                                          dt.day.toString() +
                                          '.' +
                                          dt.month.toString() +
                                          '.' +
                                          dt.year.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (cars.state == 'disabled')
                        InkWell(
                          onTap: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text(
                                      cars.number.toString(),
                                      style: numberTextStyle,
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                'Status: ' +
                                                    cars.state.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: appBarVideoPlayer),
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                dt.hour.toString() +
                                                    ':' +
                                                    dt.minute.toString() +
                                                    ':' +
                                                    dt.second.toString() +
                                                    ',' +
                                                    dt.day.toString() +
                                                    '.' +
                                                    dt.month.toString() +
                                                    '.' +
                                                    dt.year.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: appBarVideoPlayer),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () => {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop()
                                              },
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                                color: appBarVideoPlayer),
                                          ))
                                    ],
                                  );
                                })
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.01,
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.01),
                            child: Container(
                              color: orangeColor,
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    cars.number.toString(),
                                    style: numberTextStyle,
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: Text(
                                      dt.hour.toString() +
                                          ':' +
                                          dt.minute.toString() +
                                          ':' +
                                          dt.second.toString() +
                                          ',' +
                                          dt.day.toString() +
                                          '.' +
                                          dt.month.toString() +
                                          '.' +
                                          dt.year.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            }
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
