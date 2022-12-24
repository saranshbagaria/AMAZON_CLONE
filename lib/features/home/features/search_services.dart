import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../Providers/user_provider.dart';
import '../../../constants/error_hadlig.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../admin/services/product.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      loginErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          var length = jsonDecode(res.body).length;
          for (int i = 0; i < length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }

    return productList;
  }
}
