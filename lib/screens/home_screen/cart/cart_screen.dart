import 'package:adidas/components/custom_buttons/custom_button1.dart';
import 'package:adidas/components/custom_text/custom_poppins_text.dart';
import 'package:adidas/providers/cart_provider.dart';
import 'package:adidas/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CartProvider>(builder: (context, value, child) {
            return Column(
              children: [
                const Row(
                  children: [
                    BackButton(),
                    Spacer(),
                    CustomPoppinsText(
                      text: "My Cart",
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer()
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFEBEEF0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(value
                                            .cartItems[index].model.image))),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomPoppinsText(
                                    text: value.cartItems[index].model.title,
                                    fontSize: 18,
                                  ),
                                  Chip(
                                    label: Text(
                                        "LKR ${value.cartItems[index].model.price * value.cartItems[index].quantity}0"),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade900,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        value.decreseCartItemQuantity(index);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.3),
                                        radius: 15,
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${value.cartItems[index].quantity}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        value.increaseCartItemQuantity(index);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.3),
                                        radius: 15,
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomPoppinsText(
                              text: "Total",
                              color: Colors.white,
                            ),
                            CustomPoppinsText(
                              text: "LKR  ${value.calculateTotal()}0/=",
                              color: Colors.orange.shade300,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton1(
                            size: MediaQuery.sizeOf(context),
                            text: "Buy Now",
                            bgColor: Colors.orange,
                            ontap: () {
                              Provider.of<PaymentProvider>(context,
                                      listen: false)
                                  .getPayment(
                                      "${value.calculateTotal().replaceAll(".", "")}0");
                            }),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
