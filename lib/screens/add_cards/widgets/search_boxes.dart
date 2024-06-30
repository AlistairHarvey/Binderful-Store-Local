import 'package:binderful_store/constants/constants.dart';
import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    required this.controller,
    required this.focus,
    super.key,
  });

  final ExtendedAddCardController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Search by Card No',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const Gutter(),
          child: SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                label: Text(
                  'Card Number/Code:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                border: const OutlineInputBorder(),
                suffix: ElevatedButton(
                  onPressed: () async {
                    if (controller.state.cardNoController.text.isNotEmpty) {
                      await controller.lookupCard();
                    } else {
                      //TODO: Throw validation error
                    }
                  },
                  child: const Text('Search'),
                ),
              ),
              controller: controller.state.cardNoController,
              focusNode: focus,
              autofocus: true,
              onSubmitted: (v) => controller.lookupCard(),
            ),
          ),
        ),
      ],
    );
  }
}
