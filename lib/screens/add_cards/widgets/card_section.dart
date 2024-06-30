import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:binderful_store/screens/add_cards/widgets/card_pricing_tile.dart';
import 'package:binderful_store/screens/add_cards/widgets/card_tile.dart';
import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  const CardSection({
    required this.controller,
    super.key,
  });

  final ExtendedAddCardController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          if (controller.state.results.isNotEmpty) ...[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: controller.state.results.length > 1
                    ? MediaQuery.of(context).size.width
                    : 350,
                maxHeight: 500,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.state.results.length,
                itemBuilder: (context, index) => CardTile(
                  card: controller.state.results[index],
                  controller: controller,
                ),
              ),
            ),
          ],
          if (controller.state.results.length == 1)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  CardPricingTile(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
