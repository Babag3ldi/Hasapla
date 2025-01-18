import 'package:hive/hive.dart';

import '../model/budget_model.dart';

void registerAdapters() {
	Hive.registerAdapter(BudgetModelAdapter());
}
