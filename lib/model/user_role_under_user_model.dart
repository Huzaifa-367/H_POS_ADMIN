import 'package:pos_admin/model/seller_info_model.dart';
import 'package:pos_admin/model/user_role_model.dart';

class UserRoleUnderUser {
  late SellerInfoModel sellerInfoModel;
  late List<UserRoleModel> userRoles;

  UserRoleUnderUser({required this.sellerInfoModel, required this.userRoles});
}
