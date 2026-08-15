import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class WalletService {
  // ================= جلب بيانات المحفظة =================
  Future<Map<String, dynamic>?> fetchWallet() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/wallet',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (wallet): ${e.message}");
      return null;
    } catch (e) {
      print("❌ Error (wallet): $e");
      return null;
    }
  }

  // ================= إيداع أموال =================
  Future<Map<String, dynamic>?> deposit({required double amount}) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/wallet/deposit',
        data: {'amount': amount},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (deposit): ${e.message}");
      return null;
    } catch (e) {
      print("❌ Error (deposit): $e");
      return null;
    }
  }
}