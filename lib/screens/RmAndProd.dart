import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:edsa/objectbox.g.dart';
import 'package:edsa/widgets/text.dart';

import '../models/inventory.dart';

class RMandProductScreen extends StatefulWidget {
  late Store store;

  RMandProductScreen({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<RMandProductScreen> createState() => _RMandProductScreenState();
}

class _RMandProductScreenState extends State<RMandProductScreen> {
  bool hasInitialized = false;

  late Stream<List<Product>> productStream;
  late Stream<List<RawMaterial>> rmStream;

  @override
  void initState() {
    super.initState();
    setState(() {
      productStream = widget.store.box<Product>().query().watch(triggerImmediately: true).map((query) => query.find());
      rmStream = widget.store.box<RawMaterial>().query().watch(triggerImmediately: true).map((query) => query.find());
      hasInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SvgPicture.asset("assets/EDSASVG.svg"),
        ),
        // const SizedBox(height: 10),
        const Divider(),
        const SimpleHeadline(text: "Products"),
        Expanded(
          child: Container(
            height: 300,
            child: hasInitialized
                ? StreamBuilder<List<Product>>(
                    stream: productStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ProductList(products: snapshot.data!);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
        const Divider(),
        const SimpleHeadline(text: "Raw Materials"),
        Expanded(
          child: Container(
            child: hasInitialized
                ? StreamBuilder<List<RawMaterial>>(
                    stream: rmStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RawMaterialList(rms: snapshot.data!);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}

class ProductList extends StatefulWidget {
  final List<Product> products;

  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        physics: const ClampingScrollPhysics(),
        children: widget.products
            .map((product) => ListTile(
                  title: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      // color: Colors.white,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class RawMaterialList extends StatefulWidget {
  final List<RawMaterial> rms;

  const RawMaterialList({
    Key? key,
    required this.rms,
  }) : super(key: key);

  @override
  State<RawMaterialList> createState() => _RawMaterialListState();
}

class _RawMaterialListState extends State<RawMaterialList> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          physics: const ClampingScrollPhysics(),
          children: widget.rms
              .map((rm) => ListTile(
                    leading: Text(
                      rm.id.toString() + '.',
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        // color: Colors.white,
                      ),
                    ),
                    title: Text(
                      rm.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        // color: Colors.white,
                      ),
                    ),
                    trailing: Text(
                      rm.quantity.toString() + ' Kg',
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        // color: Colors.white,
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}
