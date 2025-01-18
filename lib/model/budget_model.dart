import 'package:hive/hive.dart';

import '../hive_helper/fields/budget_model_fields.dart';
import '../hive_helper/hive_adapters.dart';
import '../hive_helper/hive_types.dart';


part 'budget_model.g.dart';


@HiveType(typeId: HiveTypes.budgetModel, adapterName: HiveAdapters.budgetModel)
class BudgetModel extends HiveObject{
	@HiveField(BudgetModelFields.id)
    final int id;
	@HiveField(BudgetModelFields.images)
    final String images;
	@HiveField(BudgetModelFields.name)
    final String name;
	@HiveField(BudgetModelFields.price)
    final String price;
	@HiveField(BudgetModelFields.time)
    final DateTime time;
  @HiveField(BudgetModelFields.category)
    final String category;
  @HiveField(BudgetModelFields.status)
    final int status;

    BudgetModel({
        required this.id,
        required this.images,
        required this.name,
        required this.price,
        required this.time,
        required this.category,
        required this.status
    });
}