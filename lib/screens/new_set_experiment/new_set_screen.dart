import 'package:binderful_store/screens/new_set_experiment/controller/new_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddNewSetScreen extends StatefulWidget {
  const AddNewSetScreen({super.key});

  @override
  State<AddNewSetScreen> createState() => _AddNewSetScreenState();
}

class _AddNewSetScreenState extends State<AddNewSetScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _body(controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: ElevatedButton(
                  onPressed: controller.currentScreen > 1
                      ? () {
                          controller.changeScreen(--controller.currentScreen);
                        }
                      : context.pop,
                  child: const SizedBox(
                    width: 100,
                    child: Center(child: Text('back')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: ElevatedButton(
                  onPressed: () {
                    controller.changeScreen(++controller.currentScreen);
                  },
                  child: const SizedBox(
                    width: 100,
                    child: Center(child: Text('Next')),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(NewSetController controller) {
    switch (controller.currentScreen) {
      case 1:
        return const TestingFromEmail();
      case 2:
        return const ProductCounts();
      case 3:
        return const ProductInformation();
      case 4:
        return const ReleaseDates();
      default:
        return const Products();
    }
  }
}

class TestingFromEmail extends StatefulWidget {
  const TestingFromEmail({super.key});

  @override
  State<TestingFromEmail> createState() => _TestingFromEmailState();
}

class _TestingFromEmailState extends State<TestingFromEmail> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  maxLines: null,
                  controller: textController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('From Email Text'),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => controller.setEmailText(textController.text),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ProductCounts extends StatelessWidget {
  const ProductCounts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Column(
        children: [
          ProductCountSelector(
            title: 'ETB Count:',
            value: controller.etbCount,
          ),
          ProductCountSelector(
            title: 'Checklane Count:',
            value: controller.checkLaneCount,
          ),
          ProductCountSelector(
            title: 'Triple Pack Count:',
            value: controller.triplePackCount,
          ),
        ],
      ),
    );
  }
}

class ProductCountSelector extends StatefulWidget {
  const ProductCountSelector({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final int value;

  @override
  State<ProductCountSelector> createState() => _ProductCountSelectorState();
}

class _ProductCountSelectorState extends State<ProductCountSelector> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SegmentedButton(
            segments: const <ButtonSegment<int>>[
              ButtonSegment<int>(
                value: 1,
                label: Text('One'),
              ),
              ButtonSegment<int>(
                value: 2,
                label: Text('Two'),
              ),
            ],
            selected: <int>{value},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() {
                value = newSelection.first;
              });
            },
          ),
        ),
      ],
    );
  }
}

class SetName extends StatelessWidget {
  const SetName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  autofocus: true,
                  initialValue: controller.setName,
                  onChanged: controller.setSetName,
                  onFieldSubmitted: (v) => controller.changeScreen(2),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Set Name'),
                  ),
                ),
              ),
            ),
            Checkbox(
              value: controller.isSpecailSet,
              onChanged: (value) {
                controller.setSpecailSet(v: value ?? false);
              },
            ),
            const Text('Specail Set?'),
          ],
        ),
      ],
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);

    return Column(
      children: [
        Heading(controller: controller),
        Column(
          children: [
            if (controller.etbCount > 1) const ETBNames(),
            if (controller.checkLaneCount > 1) const ChecklaneNames(),
            if (controller.triplePackCount > 1) const TriplePackNames(),
          ],
        ),
      ],
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    required this.controller,
    super.key,
  });

  final NewSetController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        controller.setName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}

class ETBNames extends StatelessWidget {
  const ETBNames({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ETB Variant Names'),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('ETB Variant 1 Name'),
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('ETB Variant 2 Name'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChecklaneNames extends StatelessWidget {
  const ChecklaneNames({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Checklane Variant Names'),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Checklane Variant 1 Name'),
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Checklane Variant 2 Name'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TriplePackNames extends StatelessWidget {
  const TriplePackNames({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Triple Pack Variant Names'),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Triple Pack Variant 1 Name'),
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Triple Pack Variant 2 Name'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReleaseDates extends StatelessWidget {
  const ReleaseDates({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);

    return Column(
      children: [
        Heading(controller: controller),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              initialValue: controller.productName,
              onChanged: (v) => controller.productName = v,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Main Set Release Date'),
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              initialValue: controller.productName,
              onChanged: (v) => controller.productName = v,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Build and Battle Release Date'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<NewSetController>(
      context,
      listen: false,
    );
    controller.setProductsList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewSetController>(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            width: 400,
            height: 400,
            child: controller.boosterBoxImageURLS.isEmpty
                ? const Placeholder()
                : Image.network(controller.boosterBoxImageURLS.first),
          ),
        ),
        Column(
          children: [
            const Text('Booster Box'),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  initialValue: controller.productName,
                  onChanged: (v) => controller.productName = v,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Product Title'),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  initialValue: controller.productName,
                  onFieldSubmitted: controller.addBoosterBoxImageURL,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Image 1 URL'),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  initialValue: controller.productName,
                  onChanged: (v) => controller.productName = v,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Image 2 URL'),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  initialValue: controller.productName,
                  onChanged: (v) => controller.productName = v,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Product Title'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
