import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_admin/Repo/paypal_info_repo.dart';
import 'package:pos_admin/model/paypal_info_model.dart';

PaypalInfoRepo paypalRepo = PaypalInfoRepo();
final paypalInfoProvider = FutureProvider<PaypalInfoModel>((ref) => paypalRepo.getPaypalInfo());
