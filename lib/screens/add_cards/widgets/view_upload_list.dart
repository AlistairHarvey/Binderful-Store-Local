import 'package:binderful_store/constants/column_enum.dart';
import 'package:binderful_store/constants/constants.dart';
import 'package:binderful_store/models/card_upload_class.dart';
import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// TODO break up this file

class ViewUploadList extends StatelessWidget {
  const ViewUploadList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExtendedAddCardController>(context);

    return Padding(
      padding: const Gutter(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 260,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.state.savedCards.length,
              itemBuilder: (context, index) {
                final card = controller.state.savedCards[index];
                final body = ColumnTitle.values
                    .map<Widget>(
                      (e) => SizedBox(width: 125, child: e.field(card)),
                    )
                    .toList();
                body.add(
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      controller.removeSavedCard(index);
                    },
                  ),
                );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: body,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: £${controller.state.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const HalfGutter(),
            child: ElevatedButton(
              onPressed: () => _export(
                controller,
                context,
              ),
              child: const Text('Export'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _export(
  ExtendedAddCardController controller,
  BuildContext context,
) async {
  await controller.export().then(
    (value) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Export cards to CSV'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                value,
                style: const TextStyle(color: Colors.blue),
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: value),
                  );
                  context.pop();
                  const snackBar = SnackBar(
                    content: Text(
                      'File name copied to clipboard',
                    ),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () => _export(controller, context),
              child: const Text('Copy file name and Close'),
            ),
          ],
        ),
      );
    },
  );
}

class CardListViewTableColumn extends StatelessWidget {
  const CardListViewTableColumn({
    required this.controller,
    required this.columnTitle,
    super.key,
  });

  final ExtendedAddCardController controller;
  final ColumnTitle columnTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const HalfGutter(),
          child: Text(
            columnTitle.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        for (final pokemon in controller.state.savedCards) ...[
          columnTitle.field(pokemon),
        ],
      ],
    );
  }
}

class EditableTextField extends StatefulWidget {
  const EditableTextField({
    required this.title,
    required this.pokemon,
    required this.isQunatity,
    super.key,
  });

  final String title;
  final CardUploadClass pokemon;
  final bool isQunatity;

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.text = widget.title;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExtendedAddCardController>(context);

    return SizedBox(
      height: 40,
      width: 100,
      child: TextField(
        controller: textController,
        onChanged: (v) {
          if (v.isNotEmpty) {
            final card = controller.state.savedCards
                .firstWhere((element) => element == widget.pokemon);
            if (widget.isQunatity) {
              controller.updateCardQunatity(v, card);
            } else {
              controller.updateCardPrice(v, card);
            }
          }
        },
      ),
    );
  }
}
