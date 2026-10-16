import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharePulsButtom extends StatelessWidget {
  final String productsId;
  const SharePulsButtom({super.key, required this.productsId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final String productLink =
            "https://kason-application.web.app/products/$productsId";
        final String shareMessage = " Look at this product: $productLink";
        await SharePlus.instance.share(
          ShareParams(
            text: shareMessage,
            subject: "Check out this product on Huma Volve",
          ),
        );
      },
      icon: Icon(Icons.share),
    );
  }
}
