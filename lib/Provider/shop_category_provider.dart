import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_admin/Repo/shop_category_repo.dart';
import 'package:pos_admin/model/shop_category_model.dart';

ShopCategoryRepo categoryRepo = ShopCategoryRepo();
final shopCategoryProvider = FutureProvider<List<ShopCategoryModel>>((ref) => categoryRepo.getAllCategory());
