import 'package:binderful_store/screens/update_sets/subscreens/set_screen.dart';
import 'package:binderful_store/screens/update_sets/update_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateSetsScreen extends StatefulWidget {
  const UpdateSetsScreen({super.key});

  @override
  State<UpdateSetsScreen> createState() => _UpdateSetsScreenState();
}

class _UpdateSetsScreenState extends State<UpdateSetsScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<UpdateSetController>(context, listen: false);
    controller.populateSetsFromRaven();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpdateSetController>(context);
    return Scaffold(
      body: controller.screen == SetScreenEnum.setList
          ? SetScreen(controller: controller)
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.setScreen(SetScreenEnum.setList);
                            controller.setCards.clear();
                          },
                          child: const Text('Back'),
                        ),
                      ),
                      const Expanded(
                        child: Center(child: Text('Update Set Cards:')),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.uploadAllSetCardsToRaven,
                          child: const Text('Add All to Raven DB'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          child: const Text('Update Price History'),
                          onPressed: () {
                            controller.updateSetPricingHistory(null);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.loadingSet)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.setCards.length,
                      itemBuilder: (context, index) {
                        final card = controller.setCards[index];
                        final hasMatch = controller.setCardsFromRaven.any(
                          (element) =>
                              element.name.toLowerCase() ==
                              card.name.toLowerCase(),
                        );
                        return ListTile(
                          onTap: () =>
                              controller.setScreen(SetScreenEnum.setCards),
                          leading: Text(
                            card.name,
                          ),
                          trailing: Text(
                            '${card.rarity} ${card.number}/${_getSetTotal(card.number, controller)}',
                            style: TextStyle(
                              color: hasMatch ? Colors.green : Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  String _getSetTotal(
    String number,
    UpdateSetController controller,
  ) {
    if (number.toLowerCase().contains('gg')) {
      return 'GG70';
    } else if (number.toLowerCase().contains('tg')) {
      return 'TG30';
    } else {
      return controller.setTotal.toString();
    }
  }
}
