import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/error_hadlig.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants/global_variable.dart';

class ProductDetailServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );

      loginErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context: context, text: 'Product Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }

  // get all the product

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      loginErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          var length = jsonDecode(res.body).length;
          for (int i = 0; i < length; i++) {
            var decoded = jsonDecode(res.body)[i];
            var encoded = jsonEncode(decoded);
            Product temp_product = Product.fromJson(encoded);
            productList.add(temp_product);
          }
        },
      );
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }

    return productList;
  }

  // delete product on clicking delete icon in product

}
