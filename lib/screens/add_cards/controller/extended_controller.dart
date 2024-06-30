import 'package:binderful_store/screens/add_cards/controller/add_cards_controller.dart';
import 'package:binderful_store/screens/add_cards/controller/mixins/cards_to_excel.dart';
import 'package:binderful_store/screens/add_cards/controller/mixins/lookups.dart';

class ExtendedAddCardController extends AddCardController
    with Lookups, CardsToExcel {}
