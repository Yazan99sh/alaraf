import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class GoldBuyViewModel extends ChangeNotifier{
  var _productIds = {'alaraf_50_gold','alaraf_100_gold'};
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> products = [];
  var isLoaded = false;

  var key = GlobalKey<ScaffoldState>();
  GoldBuyViewModel(){
    init();
  }
  init(){
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
  }
  initStoreInfo() async {
    ProductDetailsResponse productDetailResponse =
    await _connection.queryProductDetails(_productIds);
    if (productDetailResponse.error == null) {
        products = productDetailResponse.productDetails;
        notifyListeners();
    }
  }
  buyProduct(ProductDetails p) {
    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: p);
    _connection.buyConsumable(purchaseParam: purchaseParam);
  }
  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          key.currentState.showSnackBar(SnackBar(content: Text('Buyed ${purchaseDetails.productID}')));
        }
      }
    });
  }
}