import 'package:adidas/components/custom_text/custom_poppins_text.dart';
import 'package:adidas/models/sneaker_model.dart';
import 'package:adidas/providers/auth_provider.dart';
import 'package:adidas/utils/demo_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<SneakerModel> sneakers = DemoData.sneakers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const Row(
                children: [
                  BackButton(),
                  CustomPoppinsText(text: "Favorite Items")
                ],
              ),
              Divider(
                color: Colors.grey.shade700,
              ),
              Expanded(
                child: Consumer<AuthProvider>(builder: (context, value, child) {
                  return value.favItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.favItems.length,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(value
                                                  .favItems[index].image))),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomPoppinsText(
                                          text: value.favItems[index].title,
                                          fontSize: 18,
                                        ),
                                        Chip(
                                          label: Text(
                                              "LKR ${value.favItems[index].price}0"),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          value.removeFromFav(
                                              value.favItems[index]);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Image.network(
                            "https://img.freepik.com/premium-vector/no-data-concept-illustration_86047-488.jpg",
                            width: 300,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                }),
              )
            ],
          ),
        ));
  }
}
