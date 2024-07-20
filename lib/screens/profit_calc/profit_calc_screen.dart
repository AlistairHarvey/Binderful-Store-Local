import 'package:flutter/material.dart';

class ProfitCalc extends StatefulWidget {
  const ProfitCalc({super.key});

  @override
  State<ProfitCalc> createState() => _ProfitCalcState();
}

class _ProfitCalcState extends State<ProfitCalc> {
  late final TextEditingController costCostController;
  late final TextEditingController shippingController;
  late final TextEditingController shopifyCostController;
  late final TextEditingController vatController;
  late final TextEditingController corporationTaxController;
  late final TextEditingController salePriceController;
  late final TextEditingController caseCountController;
  double profit = 0;
  double percent = 0;
  double profit2 = 0;
  double percent2 = 0;
  double profitCase = 0;
  double percentCase = 0;

  @override
  void initState() {
    super.initState();
    costCostController = TextEditingController();
    shippingController = TextEditingController();
    shopifyCostController = TextEditingController();
    vatController = TextEditingController();
    corporationTaxController = TextEditingController();
    salePriceController = TextEditingController();
    caseCountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Profit calc'),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: costCostController,
                    decoration: const InputDecoration(
                      label: Text('Cost'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: shippingController,
                    decoration: const InputDecoration(
                      label: Text('Shipping'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: shopifyCostController,
                    decoration: const InputDecoration(
                      label: Text('Shopify'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                    enabled: false,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: vatController,
                    decoration: const InputDecoration(
                      label: Text('VAT'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                    enabled: false,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: corporationTaxController,
                    decoration: const InputDecoration(
                      label: Text('Tax'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                    enabled: false,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: salePriceController,
                    decoration: const InputDecoration(
                      label: Text('Sale Price'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: caseCountController,
                    decoration: const InputDecoration(
                      label: Text('Case Count'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => {
                      setState(_profit),
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Profit: £${profit.toStringAsFixed(2)}, '
            'Percent: ${percent.toStringAsFixed(2)}%',
            style: const TextStyle(color: Colors.green),
          ),
          Text(
            '2: £${profit2.toStringAsFixed(2)}, '
            'Percent: ${percent2.toStringAsFixed(2)}%',
            style: const TextStyle(color: Colors.green),
          ),
          Text(
            'CASE: £${profitCase.toStringAsFixed(2)}, '
            'Percent: ${percentCase.toStringAsFixed(2)}%',
            style: const TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }

  void _profit() {
    final salesPrice = double.tryParse(salePriceController.text) ?? 0;
    if (salesPrice == 0) return;
    final vat = salesPrice / 6;
    final shopifyCost = (salesPrice * 0.02) + 0.25;
    final shipping = double.tryParse(shippingController.text) ?? 0;
    final cost = double.tryParse(costCostController.text) ?? 0;
    final preTax = salesPrice - cost - shipping - shopifyCost - vat;

    final corpTax = preTax * 0.19;
    profit = preTax - corpTax;

    percent = (profit / cost) * 100;

    final preTaxprofit2 = (salesPrice * 2) -
        (cost * 2) -
        shipping -
        (shopifyCost * 2) -
        (vat * 2);

    final corpTax2 = preTaxprofit2 * 0.19;
    profit2 = preTaxprofit2 - corpTax2;

    percent2 = (profit2 / (cost * 2)) * 100;

    final caseCount = int.tryParse(caseCountController.text) ?? 1;
    final preTaxprofitCase = (salesPrice * caseCount) -
        (cost * caseCount) -
        shipping -
        (shopifyCost * caseCount) -
        (vat * caseCount);
    final corpTaxCase = preTaxprofitCase * 0.19;

    profitCase = preTaxprofitCase - corpTaxCase;

    percentCase = (profitCase / (cost * caseCount)) * 100;

    vatController.text = vat.toString();
    shopifyCostController.text = shopifyCost.toString();
    corporationTaxController.text = corpTax.toString();
  }
}
