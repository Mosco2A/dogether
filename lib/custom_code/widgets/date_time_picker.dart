// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:board_datetime_picker/board_datetime_picker.dart';

class DateTimePicker extends StatelessWidget {
  final double? width; // Ajout du paramètre width
  final double? height; // Ajout du paramètre height

  const DateTimePicker({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board DateTime Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 241),
        useMaterial3: false,
      ),
      home: MySampleApp(
          width: width, height: height), // Passer les paramètres à MySampleApp
    );
  }
}

class MySampleApp extends StatefulWidget {
  final double? width;
  final double? height;

  const MySampleApp({super.key, this.width, this.height});

  @override
  State<MySampleApp> createState() => _MySampleAppState();
}

class _MySampleAppState extends State<MySampleApp> {
  final scrollController = ScrollController();
  final controller = BoardDateTimeController();
  final ValueNotifier<DateTime> builderDate = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Widget scaffold() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Board DateTime Picker Example'),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 250),
        body: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: widget.width ??
                    560, // Utilisation de la largeur fournie ou valeur par défaut
              ),
              child: Column(
                children: [
                  SectionWidget(
                    title: 'Form',
                    items: [InputFieldWidget()],
                  ),
                  const SizedBox(height: 24),
                  SectionWidget(
                    title: 'Picker (Single Selection)',
                    items: [
                      PickerItemWidget(
                        pickerType: DateTimePickerType.datetime,
                      ),
                      PickerItemWidget(
                        pickerType: DateTimePickerType.date,
                      ),
                      PickerItemWidget(
                        pickerType: DateTimePickerType.time,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionWidget(
                    title: 'Picker (Multi Selection)',
                    items: [
                      PickerMultiSelectionItemWidget(
                        pickerType: DateTimePickerType.datetime,
                      ),
                      PickerMultiSelectionItemWidget(
                        pickerType: DateTimePickerType.date,
                      ),
                      PickerMultiSelectionItemWidget(
                        pickerType: DateTimePickerType.time,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionWidget(
                    title: 'Builder Picker',
                    items: [
                      PickerBuilderItemWidget(
                        pickerType: DateTimePickerType.datetime,
                        date: builderDate,
                        onOpen: () async {
                          controller.open(
                            DateTimePickerType.datetime,
                            builderDate.value,
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 300));
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return BoardDateTimeBuilder<BoardDateTimeCommonResult>(
      builder: (context) => scaffold(),
      controller: controller,
      options: const BoardDateTimeOptions(
        languages: BoardPickerLanguages.en(),
      ),
      onChange: (val) {
        builderDate.value = val;
      },
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SectionWidget({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8, left: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      ],
    );
  }
}

class PickerItemWidget extends StatelessWidget {
  final DateTimePickerType pickerType;
  final ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());

  PickerItemWidget({super.key, required this.pickerType});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showBoardDateTimePicker(
            context: context,
            pickerType: pickerType,
            options: BoardDateTimeOptions(
              languages: const BoardPickerLanguages.en(),
              startDayOfWeek: DateTime.sunday,
              pickerFormat: PickerFormat.ymd,
              withSecond: DateTimePickerType.time == pickerType,
              customOptions: DateTimePickerType.time == pickerType
                  ? BoardPickerCustomOptions(
                      seconds: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55],
                    )
                  : null,
            ),
            valueNotifier: date,
          );
          if (result != null) {
            date.value = result;
            print('result: $result');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              Material(
                color: pickerType.color,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Icon(
                      pickerType.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  pickerType.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: date,
                builder: (context, data, _) {
                  return Text(
                    BoardDateFormat(pickerType.formatter(
                      withSecond: DateTimePickerType.time == pickerType,
                    )).format(data),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PickerMultiSelectionItemWidget extends StatelessWidget {
  final DateTimePickerType pickerType;
  final ValueNotifier<DateTime> start = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> end = ValueNotifier(
    DateTime.now().add(const Duration(days: 7)),
  );

  PickerMultiSelectionItemWidget({super.key, required this.pickerType});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showBoardDateTimeMultiPicker(
            context: context,
            pickerType: pickerType,
            startDate: start.value,
            endDate: end.value,
            options: const BoardDateTimeOptions(
              languages: BoardPickerLanguages.en(),
              startDayOfWeek: DateTime.sunday,
              pickerFormat: PickerFormat.ymd,
            ),
          );
          if (result != null) {
            start.value = result.start;
            end.value = result.end;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              Material(
                color: pickerType.color,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Icon(
                      pickerType.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  pickerType.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: start,
                    builder: (context, data, _) {
                      return Text(
                        BoardDateFormat(pickerType.format).format(data),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: end,
                    builder: (context, data, _) {
                      return Text(
                        BoardDateFormat(pickerType.format).format(data),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PickerBuilderItemWidget extends StatelessWidget {
  final DateTimePickerType pickerType;
  final ValueNotifier<DateTime> date;

  const PickerBuilderItemWidget({
    super.key,
    required this.pickerType,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showBoardDateTimePicker(
            context: context,
            pickerType: pickerType,
            options: const BoardDateTimeOptions(
              languages: BoardPickerLanguages.en(),
              startDayOfWeek: DateTime.sunday,
              pickerFormat: PickerFormat.ymd,
            ),
            valueNotifier: date,
          );
          if (result != null) {
            date.value = result;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              Material(
                color: pickerType.color,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Icon(
                      pickerType.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  pickerType.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: date,
                builder: (context, data, _) {
                  return Text(
                    BoardDateFormat(pickerType.format).format(data),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
