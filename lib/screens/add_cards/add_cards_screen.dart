import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:binderful_store/screens/add_cards/widgets/card_section.dart';
import 'package:binderful_store/screens/add_cards/widgets/search_section.dart';
import 'package:binderful_store/screens/add_cards/widgets/view_upload_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCardsScreen extends StatefulWidget {
  const AddCardsScreen({super.key});

  @override
  State<AddCardsScreen> createState() => _AddCardsScreenState();
}

class _AddCardsScreenState extends State<AddCardsScreen> {
  late final FocusNode focus;

  @override
  void initState() {
    super.initState();
    focus = FocusNode();
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExtendedAddCardController>(context);
    return Scaffold(
      body: Column(
        children: [
          SearchSection(
            controller: controller,
            focus: focus,
          ),
          switch (controller.state.loading) {
            true => const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            false => Column(
                children: [
                  SingleChildScrollView(
                    child: switch (controller.state.isViewAll) {
                      true => const ViewUploadList(),
                      false => CardSection(
                          controller: controller,
                        ),
                    },
                  ),
                ],
              ),
          },
        ],
      ),
    );
  }
}
