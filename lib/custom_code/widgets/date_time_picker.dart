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
  final ValueNotifier<DateTime>? selectedDate;

  const DateTimePicker({Key? key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board DateTime Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 241),
        useMaterial3: false,
      ),
      home: const MySampleApp(),
    );
  }
}

class MySampleApp extends StatefulWidget {
  const MySampleApp({Key? key}) : super(key: key);

  @override
  State<MySampleApp> createState() => _MySampleAppState();
}

class _MySampleAppState extends State<MySampleApp> {
  final scrollController = ScrollController();
  final controller = BoardDateTimeController();
  final ValueNotifier<DateTime> builderDate = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BoardDateTimeBuilder<BoardDateTimeCommonResult>(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Board DateTime Picker Example'),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            children: [
              SectionWidget(
                title: 'Builder Picker',
                items: [
                  PickerBuilderItemWidget(
                    pickerType: DateTimePickerType.datetime,
                    date: builderDate,
                    onOpen: () async {
                      controller.open(
                          DateTimePickerType.datetime, builderDate.value);
                      await Future.delayed(const Duration(milliseconds: 300));
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

  const SectionWidget({Key? key, required this.title, required this.items})
      : super(key: key);

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

class PickerBuilderItemWidget extends StatelessWidget {
  const PickerBuilderItemWidget({
    Key? key,
    required this.pickerType,
    required this.date,
    required this.onOpen,
  }) : super(key: key);

  final DateTimePickerType pickerType;
  final ValueNotifier<DateTime> date;
  final void Function() onOpen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          onOpen.call();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              Material(
                color: Colors.blue, // Couleur par défaut
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
                    BoardDateFormat(pickerType.formatter()).format(data),
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

extension DateTimePickerTypeExtension on DateTimePickerType {
  String get title {
    switch (this) {
      case DateTimePickerType.date:
        return 'Date';
      case DateTimePickerType.datetime:
        return 'DateTime';
      case DateTimePickerType.time:
        return 'Time';
    }
  }

  IconData get icon {
    switch (this) {
      case DateTimePickerType.date:
        return Icons.date_range_rounded;
      case DateTimePickerType.datetime:
        return Icons.date_range_rounded;
      case DateTimePickerType.time:
        return Icons.schedule_rounded;
    }
  }

  String formatter({bool withSecond = false}) {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        return withSecond ? 'HH:mm:ss' : 'HH:mm';
    }
  }
}
