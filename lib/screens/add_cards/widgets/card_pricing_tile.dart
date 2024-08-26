import 'package:binderful_store/constants/constants.dart';
import 'package:binderful_store/screens/add_cards/controller/add_cards_controller.dart';
import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPricingTile extends StatefulWidget {
  const CardPricingTile({super.key});

  @override
  State<CardPricingTile> createState() => _CardPricingTileState();
}

class _CardPricingTileState extends State<CardPricingTile> {
  late final TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController();
    quantityController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExtendedAddCardController>(context);
    final card = controller.state.results.first;
    return Column(
      children: [
        Padding(
          padding: const HalfGutter(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8, bottom: 16),
                child: Text(
                  'Quantity:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              Padding(
                padding: const Gutter(),
                child: SizedBox(
                  width: 80,
                  height: 60,
                  child: TextField(
                    decoration:
                        const InputDecoration(border: UnderlineInputBorder()),
                    controller: quantityController,
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const HalfGutter(),
                      child: Column(
                        children: [
                          const Text('PokeCardValues Pricing'),
                          Row(
                            children: [
                              if (pricingListCheck(
                                controller.state.price?.holoValues,
                              ))
                                Padding(
                                  padding: const HalfGutter(),
                                  child: Column(
                                    children: [
                                      const Text('Holo'),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          _price(controller).toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (pricingListCheck(
                                controller.state.price?.reverseHoloValues,
                              ))
                                Padding(
                                  padding: const HalfGutter(),
                                  child: Column(
                                    children: [
                                      const Text('Reverse Holo'),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          controller.state.price!
                                              .reverseHoloValues.last
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (pricingListCheck(
                                controller.state.price?.nonHoloValues,
                              ))
                                Padding(
                                  padding: const HalfGutter(),
                                  child: Column(
                                    children: [
                                      const Text('Common'),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          controller
                                              .state.price!.nonHoloValues.last
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8, bottom: 16),
                child: Text(
                  'Custom Price: £',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 80,
                  height: 60,
                  child: TextField(
                    decoration:
                        const InputDecoration(border: UnderlineInputBorder()),
                    controller: controller.state.priceController,
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              controller.addCardToList(
                card,
                double.parse(controller.state.priceController.text),
                'NM',
                int.parse(quantityController.text),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text('ADD'),
            ),
          ),
        ),
      ],
    );
  }

  bool pricingListCheck(List<double>? values) {
    if (values == null) return false;
    if (values.isEmpty) return false;
    if (values.last == 0.0) return false;
    return true;
  }

  double _price(
    AddCardController controller,
  ) {
    return controller.state.price?.holoValues.last ??
        (controller.state.isReverseHoloMode ? 0.5 : 0.0);
  }
}
