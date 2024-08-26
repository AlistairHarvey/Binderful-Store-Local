import 'package:binderful_store/constants/constants.dart';
import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:binderful_store/screens/add_cards/widgets/search_boxes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    required this.controller,
    required this.focus,
    super.key,
  });

  final ExtendedAddCardController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          SearchBox(
            controller: controller,
            focus: focus,
          ),
          Column(
            children: [
              Padding(
                padding: const Gutter(),
                child: ElevatedButton(
                  onPressed: controller.tradeInMode,
                  child: const Text('Trade In Mode'),
                ),
              ),
              Padding(
                padding: const Gutter(),
                child: ElevatedButton(
                  onPressed: controller.reverseHoloMode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.state.isReverseHoloMode
                        ? Colors.green
                        : Colors.red,
                  ),
                  child: const Text('Reverse Holo Mode'),
                ),
              ),
            ],
          ),
          Column(
            children: [
              if (!controller.state.isViewAll)
                Row(
                  children: [
                    Text(
                      'Total Saved Cards: '
                      '${controller.state.savedCards.length}',
                    ),
                    Padding(
                      padding: const Gutter(),
                      child: ElevatedButton(
                        onPressed: controller.viewAll,
                        child: const Text('View'),
                      ),
                    ),
                  ],
                ),
              if (controller.state.isViewAll)
                Padding(
                  padding: const Gutter(),
                  child: ElevatedButton(
                    onPressed: controller.addMore,
                    child: const Text('Add More'),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: controller.clear,
                  child: const Text('Clear'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
