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

import '../../../constants/global_variable.dart';

class AdminServices {
  void sellProduct(
    BuildContext context,
    String name,
    String description,
    double price,
    double quantity,
    String category,
    List<File> images,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // ignore: unused_local_variable
      /**
       * here i am using cludinary as cloud option
       *  dlumfa1fo  is cloud name
       *  ehirmgln is cloud preset
       */
      final cloudinary = CloudinaryPublic('dlumfa1fo', 'ehirmgln');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
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

  deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    List<Product> productList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({"_id": product.id}),
      );

      loginErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );

      return productList;
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }
}
