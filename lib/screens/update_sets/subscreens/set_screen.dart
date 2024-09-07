import 'package:binderful_store/constants/search_sort_enum.dart';
import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/screens/update_sets/update_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SetScreen extends StatelessWidget {
  const SetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);
    return Column(
      children: [
        const UpdateSetAppBar(),
        if (controller.loading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else
          const Expanded(
            child: Column(
              children: [
                UpdateSetSearchBar(),
                SetList(),
              ],
            ),
          ),
      ],
    );
  }
}

class SetList extends StatelessWidget {
  const SetList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);

    return Expanded(
      child: ListView.builder(
        itemCount: controller.filteredList.length,
        itemBuilder: (context, index) {
          final set = controller.filteredList[index];
          final hasMatch = controller.setsFromRaven.any(
            (element) => element.name.toLowerCase() == set.name.toLowerCase(),
          );

          final sameCardCount = hasMatch &&
              controller.setsFromRaven
                      .firstWhere(
                        (e) => e.name.toLowerCase() == set.name.toLowerCase(),
                      )
                      .total ==
                  set.total;

          final hasPricingHistory =
              controller.pricingHistories.any((e) => e.setID == set.id);

          return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                controller.popCardList(set.id);
                controller.setScreen(SetScreenEnum.setCards);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: hasMatch
                      ? Colors.lightBlue.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        set.name,
                        style: TextStyle(
                          color: hasMatch
                              ? sameCardCount
                                  ? Colors.green
                                  : Colors.amber
                              : Colors.red,
                        ),
                      ),
                      TrailingSetActions(
                        hasMatch: hasMatch,
                        set: set,
                        hasPricingHistory: hasPricingHistory,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class UpdateSetSearchBar extends StatelessWidget {
  const UpdateSetSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              width: 500,
              child: TextFormField(
                controller: controller.searchTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Search'),
                ),
                onChanged: (v) => controller.filterList(),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: DropdownMenu<SortBy>(
              initialSelection: SortBy.mostRecent,
              onSelected: (SortBy? value) {
                if (value != null) {
                  controller.changeSetSorting(value);
                }
              },
              dropdownMenuEntries:
                  SortBy.values.map<DropdownMenuEntry<SortBy>>((SortBy value) {
                return DropdownMenuEntry<SortBy>(
                  value: value,
                  label: value.displayString(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateSetAppBar extends StatelessWidget {
  const UpdateSetAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Back'),
            ),
          ),
          const Expanded(
            child: Center(child: Text('Update Sets:')),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Colors.orange),
              onPressed: controller.populateSetsFromRaven,
            ),
          ),
        ],
      ),
    );
  }
}

class TrailingSetActions extends StatelessWidget {
  const TrailingSetActions({
    required this.hasMatch,
    required this.set,
    required this.hasPricingHistory,
    super.key,
  });

  final bool hasMatch;
  final SetData set;
  final bool hasPricingHistory;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!hasMatch)
          AddSetButton(
            set: set,
          ),
        UpdateSetPricesButton(
          hasPricingHistory: hasPricingHistory,
          set: set,
        ),
        DeleteSetButton(
          set: set,
        ),
      ],
    );
  }
}

class AddSetButton extends StatelessWidget {
  const AddSetButton({
    required this.set,
    super.key,
  });

  final SetData set;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);

    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.add_circle_outline,
          color: Colors.green,
        ),
        onPressed: () => controller.updateSets(
          set,
        ),
      ),
    );
  }
}

class DeleteSetButton extends StatelessWidget {
  const DeleteSetButton({
    required this.set,
    super.key,
  });

  final SetData set;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);

    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Would you like to remove this '
              'set from the RavenDB?',
            ),
            content: const Text(
              'Doing this is reversable, the '
              'set can be re-added, pricing '
              'history will not be lost',
            ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: const Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.removeSetFromRaven(
                    set.id,
                  );
                  context.pop();
                },
                child: const Text(
                  'DELETE',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UpdateSetPricesButton extends StatelessWidget {
  const UpdateSetPricesButton({
    required this.hasPricingHistory,
    required this.set,
    super.key,
  });

  final bool hasPricingHistory;
  final SetData set;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);

    return ElevatedButton(
      child: Text(
        'Update Pricing',
        style: TextStyle(
          color: hasPricingHistory
              ? Colors.green
              : (hasPricingHistory &&
                      (controller.pricingHistories
                              .firstWhere(
                                (element) => element.setID == set.id,
                              )
                              .lastUpdateDate
                              ?.isBefore(
                                DateTime.now().subtract(
                                  const Duration(
                                    days: 14,
                                  ),
                                ),
                              ) ??
                          false))
                  ? Colors.red
                  : Colors.amber,
        ),
      ),
      onPressed: () {
        controller
            .updateSetPricingHistory(
          set,
        )
            .then((value) {
          if (context.mounted) {
            context.pop();
          }
        });
        showDialog<void>(
          context: context,
          builder: (context) => ChangeNotifierProvider.value(
            value: controller,
            child: const UpdatingSetProgressDialog(),
          ),
        );
      },
    );
  }
}

class UpdatingSetProgressDialog extends StatelessWidget {
  const UpdatingSetProgressDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (
          context,
          setState,
        ) {
          final controller = Provider.of<UpdateSetController>(
            context,
          );
          return Consumer<UpdateSetController>(
            builder: (
              context,
              myNotifier,
              child,
            ) {
              return Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(
                      16,
                    ),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  Text(
                    controller.priceUpdatingPrompt,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
