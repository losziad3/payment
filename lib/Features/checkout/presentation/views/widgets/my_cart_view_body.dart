import 'dart:developer';

import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_paypal/Features/checkout/data/models/amount_model.dart';
import 'package:payment_paypal/Features/checkout/data/models/item_list_model.dart';
import 'package:payment_paypal/Features/checkout/presentation/views/payment_details.dart';
import 'package:payment_paypal/Features/checkout/presentation/views/widgets/cart_info_item.dart';
import 'package:payment_paypal/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:payment_paypal/Features/checkout/presentation/views/widgets/total_price_widget.dart';
import 'package:payment_paypal/core/utils/styles.dart';
import 'package:payment_paypal/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset('assets/images/basket_image.png')),
          const SizedBox(
            height: 25,
          ),
          const OrderInfoItem(
            title: 'Order Subtotal',
            value: r'42.97$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Discount',
            value: r'0$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Shipping',
            value: r'8$',
          ),
          const Divider(
            thickness: 2,
            height: 34,
            color: Color(0xffC7C7C7),
          ),
          const TotalPrice(title: 'Total', value: r'$50.97'),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            text: 'Complete Payment',
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return const PaymentDetailsView();
              // }));

              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  builder: (context) {
                    return const PaymentMethodsBottomSheet();
                  });
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          CustomButton(text: 'Continue',
          onTap: (){
            var transactionsData = getTransactionsData();
            exceutePayPalPayment(context, transactionsData);

          },
          ),
        ],
      ),
    );
  }

  void exceutePayPalPayment(BuildContext context, ({AmountModel amount, ItemListModel itemList}) transactionsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: Constants.clientId,
        secretKey: Constants.secretKey,
        transactions:  [
          {
            "amount": transactionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionsData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }
  //Record Function
  ({AmountModel amount, ItemListModel itemList})getTransactionsData()
  {
    var amount = AmountModel(
      currency: 'USD',
      details: Details(
        shipping: '0',
        shippingDiscount: 0,
        subtotal: '100',
      ),
      total: '100',
    );
    List<OrderItemModel> orders = [
      OrderItemModel(
        currency: 'USD',
        name: 'Apple',
        price: '4',
        quantity: 10,
      ),
      OrderItemModel(
        currency: 'USD',
        name: 'Apple',
        price: '5',
        quantity: 12,
      ),
    ];
    var itemList = ItemListModel(
      orders: orders,
    );
    return (amount: amount, itemList: itemList);
  }
}
