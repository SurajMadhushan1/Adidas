import 'package:adidas/components/custom_text/custom_poppins_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import 'widget/action_bar.dart';
import 'widget/product_grid.dart';
import 'widget/slider.dart';
import 'widget/top_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomActionBar(),
                const SizedBox(
                  height: 8,
                ),
                CustomPoppinsText(
                  text:
                      "Hello ${Provider.of<AuthProvider>(context).userModel!.name}",
                  fontWeight: FontWeight.w500,
                ),
                CustomPoppinsText(
                  text: "Lets start shopping!",
                  fontSize: 15,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomSlider(),
                const SizedBox(
                  height: 10,
                ),
                TopCategories(),
                const SizedBox(height: 5),
                const ProductGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
