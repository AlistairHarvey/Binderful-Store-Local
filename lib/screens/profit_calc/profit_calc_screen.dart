import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('back'),
              ),
              const Text('Profit calc'),
              const SizedBox(),
            ],
          ),
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
                      setState(_calcProfit),
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
                      setState(_calcProfit),
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
                      setState(_calcProfit),
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
                      setState(_calcProfit),
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
                      setState(_calcProfit),
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
                      setState(_calcProfit),
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
                      setState(_calcProfit),
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

  void _calcProfit() {
    profit = _profit(1);
    profit2 = _profit(2);
    profitCase = _profit(int.tryParse(caseCountController.text) ?? 6);
  }

  double _profit(int quantity) {
    final salesPrice =
        (double.tryParse(salePriceController.text) ?? 0) * quantity;
    if (salesPrice == 0) return 0;
    final vat = calculateVat(salesPrice);
    final shopifyCost = caluclateShopifyCosts(salesPrice);
    final shipping = double.tryParse(shippingController.text) ?? 0;
    final cost = (double.tryParse(costCostController.text) ?? 0) * quantity;
    final preTax =
        calculatePreTaxProfit(salesPrice, cost, shipping, vat, shopifyCost);

    final corpTax = calculateCorpTax(preTax);
    final profit = calculateProfit(preTax, corpTax);

    if (quantity == 1) {
      percent = (profit / cost) * 100;
    } else if (quantity == 2) {
      percent2 = (profit / cost) * 100;
    } else {
      percentCase = (profit / cost) * 100;
    }
    return profit;
  }

  void _setControllers(double vat, double shopifyCost, double corpTax) {
    vatController.text = vat.toString();
    shopifyCostController.text = shopifyCost.toString();
    corporationTaxController.text = corpTax.toString();
  }
}

double calculateVat(double salesPrice) {
  return salesPrice / 6;
}

double caluclateShopifyCosts(double salesPrice) {
  return (salesPrice * 0.02) + 0.25;
}

double calculatePreTaxProfit(
  double salesPrice,
  double cost,
  double shipping,
  double vat,
  double shopifyCost,
) {
  return salesPrice - (cost + shipping + vat + shopifyCost);
}

double calculateCorpTax(double preTaxProfit) {
  return preTaxProfit * 0.19;
}

double calculateProfit(double preTaxProfit, double corpTax) {
  return preTaxProfit - corpTax;
}
