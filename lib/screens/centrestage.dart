import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:edsa/models/inventory.dart';
import 'package:edsa/screens/navigation.dart';
import 'package:edsa/widgets/text.dart';

import '../objectbox.g.dart';

class CentrePiece extends StatefulWidget {
  final Store store;

  const CentrePiece({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<CentrePiece> createState() => _CentrePieceState();
}

class _CentrePieceState extends State<CentrePiece> {
  bool hasInitialized = false;

  late Stream<List<FinishedProduct>> fpStream;
  late Stream<List<PackagedProduct>> pkgStream;
  late Stream<List<Production>> productionStream;

  @override
  void initState() {
    super.initState();
    setState(() {
      fpStream = widget.store.box<FinishedProduct>().query().watch(triggerImmediately: true).map((query) => query.find());
      pkgStream = widget.store.box<PackagedProduct>().query().watch(triggerImmediately: true).map((query) => query.find());
      productionStream = widget.store.box<Production>().query().watch(triggerImmediately: true).map((query) => query.find());
      hasInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      popUp(context);
                    },
                    child: Hero(
                      tag: "tagone",
                      child: Material(
                        color: Color.fromARGB(255, 232, 230, 233),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: const [
                              Text(
                                '12 Jan 2020',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                              SizedBox(height: 5),
                              SimpleHeadline(text: "Daily Sale"),
                              SizedBox(height: 15),
                              Text(
                                'Ksh 3939',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Color.fromARGB(255, 232, 230, 233),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Text(
                            '12 Jan 2020',
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          SizedBox(height: 5),
                          SimpleHeadline(text: "Daily Yield"),
                          SizedBox(height: 15),
                          Text(
                            'Unga 234 Kg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const SimpleHeadline(text: "In Stock"),
                    Expanded(
                      child: Container(
                        child: hasInitialized
                            ? StreamBuilder<List<FinishedProduct>>(
                                stream: fpStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return InStockList(finProducts: snapshot.data!);
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const SimpleHeadline(text: "Packaged Products"),
                    Expanded(
                      child: Container(
                        child: hasInitialized
                            ? StreamBuilder<List<PackagedProduct>>(
                                stream: pkgStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return PackagedProdList(pkgs: snapshot.data!);
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Material(
            elevation: 10,
            color: Colors.grey[400],
            child: AddProduction(store: widget.store), // Center(child: Text('production')),
          ),
        ),
      ],
    );
  }
}

popUp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Hero(
          tag: "tagone",
          child: Material(
            type: MaterialType.card,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10,
              ),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.3,
              height: 270,
              child: const Text(
                "the simple dialogue of the world",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class InStockList extends StatefulWidget {
  final List<FinishedProduct> finProducts;

  const InStockList({
    Key? key,
    required this.finProducts,
  }) : super(key: key);

  @override
  State<InStockList> createState() => _InStockListState();
}

class _InStockListState extends State<InStockList> {
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
        children: widget.finProducts.map((finProd) {
          var pr = finProd.product.target;
          return ListTile(
            title: Text(
              pr!.name,
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                // color: Colors.white,
              ),
            ),
            trailing: Text(
              finProd.qtyInStock.toString() + ' Kg',
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                // color: Colors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
    ;
  }
}

class PackagedProdList extends StatefulWidget {
  final List<PackagedProduct> pkgs;

  const PackagedProdList({
    Key? key,
    required this.pkgs,
  }) : super(key: key);

  @override
  State<PackagedProdList> createState() => _PackagedProdListState();
}

class _PackagedProdListState extends State<PackagedProdList> {
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
        children: widget.pkgs.map((pkg) {
          var package = pkg.product.target;
          return ListTile(
            title: Text(
              pkg.brandName,
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                // color: Colors.white,
              ),
            ),
            subtitle: Text(
              '${package!.name} | ${pkg.qtyPerPack}kg',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                // color: Colors.white,
              ),
            ),
            trailing: Text(
              pkg.totalAvailablePacks.toString() + ' packs',
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              print(pkg.id);
            },
          );
        }).toList(),
      ),
    );
    ;
  }
}

class Options extends StatefulWidget {
  final Store store;
  const Options({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  int id = 0;
  List<DropdownMenuItem> rawMats() {
    List rm = widget.store.box<RawMaterial>().getAll();
    List<DropdownMenuItem> output = [];
    for (RawMaterial r in rm) {
      var result = DropdownMenuItem(
        child: Text(r.name),
        value: r.id,
      );
      output.add(result);
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(
        children: [
          const Text("data"),
          // DropdownButton(
          //   value: id,
          //   items: rawMats(),
          //   onChanged: (int? newValue) {
          //     setState(() {
          //       id = newValue!;
          //     });
          //   },
          // ),
        ],
      )
    ]));
  }
}
