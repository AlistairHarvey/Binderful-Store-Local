import 'package:binderful_store/constants/constants.dart';
import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    required this.card,
    required this.controller,
    super.key,
  });

  final Pokemon card;
  final ExtendedAddCardController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const Gutter(),
      child: InkWell(
        onTap: controller.state.results.length == 1
            ? () {
                Clipboard.setData(
                  ClipboardData(
                    text: controller.state.results.first.images.large,
                  ),
                );
                const snackBar = SnackBar(
                  content: Center(
                    child: Text('Image URL copied to clipboard'),
                  ),
                  duration: Duration(
                    seconds: 1,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            : () => controller.selectCard(card),
        child: Container(
          height: 450,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(16),
            color: controller.state.results.length == 1
                ? Colors.green.withOpacity(0.8)
                : Colors.grey.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Padding(
                padding: const Gutter(),
                child: Text(
                  card.name,
                  style: TextStyle(
                    fontSize: card.name.length < 20 ? 16 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                card.set.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const Gutter(),
                child: Image.network(
                  card.images.small,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
