import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_list.dart';
import '../utils/app_routes.dart';
import '../components/product_item.dart';

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductList>(context);
    final products = productsData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) => Column(
          children: [
            ListTile(
              title: Text(products[i].title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(products[i].imageUrl),
              ),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.PRODUCT_FORM,
                          arguments: products[i],
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<ProductList>(context, listen: false)
                            .removeProduct(products[i]);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
