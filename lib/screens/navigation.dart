import 'package:flutter/material.dart';

import 'package:edsa/models/inventory.dart';
import 'package:edsa/widgets/text.dart';

import '../objectbox.g.dart';

class NavigationScreen extends StatefulWidget {
  final Store store;

  const NavigationScreen({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Material(
            elevation: 5,
            type: MaterialType.card,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_shopping_cart_outlined),
                          color: Colors.green,
                          iconSize: 70,
                        ),
                        const Text(
                          "Sell",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_basket_outlined),
                          color: Color.fromARGB(255, 199, 81, 81),
                          iconSize: 70,
                        ),
                        const Text(
                          "Buy",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.darken,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 136, 216, 226),
                  Color.fromARGB(255, 146, 91, 142),
                ],
                stops: [0, 0.8],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // open add product card
                              addProductDialogue(context, store: widget.store);
                            },
                            icon: const Icon(Icons.add_circle_outline_sharp),
                            // color: Colors.green,
                            iconSize: 70,
                            hoverColor: Color.fromARGB(255, 200, 160, 233),
                          ),
                          const Text(
                            "New Product",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // open rawmaterial reg card
                              addRawMaterialDialogue(context, store: widget.store);
                            },
                            icon: const Icon(Icons.add_box),
                            // color: Color.fromARGB(255, 199, 81, 81),
                            hoverColor: Color.fromARGB(255, 200, 160, 233),
                            iconSize: 70,
                          ),
                          const Text(
                            "New Raw Material",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // open add product card
                              addClientDialogue(context, store: widget.store);
                            },
                            icon: const Icon(Icons.person_add),
                            // color: Colors.green,
                            hoverColor: Color.fromARGB(255, 200, 160, 233),
                            iconSize: 70,
                            // hoverColor: Colors.red,
                          ),
                          const Text(
                            "New Client",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              addPkgMod(context, store: widget.store);
                            },
                            icon: const Icon(Icons.next_week),
                            // color: Color.fromARGB(255, 199, 81, 81),
                            hoverColor: Color.fromARGB(255, 200, 160, 233),
                            iconSize: 70,
                          ),
                          const Text(
                            "New Package",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // open add product card
                              addClientDialogue(context, store: widget.store);
                            },
                            icon: const Icon(Icons.quick_contacts_dialer_rounded),
                            // color: Colors.green,
                            hoverColor: Color.fromARGB(255, 69, 73, 106),
                            iconSize: 70,
                            // hoverColor: Colors.red,
                          ),
                          const Text(
                            "Address Book",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // open rawmaterial reg card
                              addRawMaterialDialogue(context, store: widget.store);
                            },
                            icon: const Icon(Icons.format_list_numbered_sharp),
                            // color: Color.fromARGB(255, 199, 81, 81),
                            hoverColor: Color.fromARGB(255, 69, 73, 106),
                            iconSize: 70,
                          ),
                          const Text(
                            "Recent Transactions",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddPkg extends StatefulWidget {
  final Store store;
  const AddPkg({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<AddPkg> createState() => _AddPkgState();
}

class _AddPkgState extends State<AddPkg> {
  late String brandName;
  late String qtyPerPack;
  late String totalPacksAvailable;
  Product? product;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<Product>> prodList() {
    List products = widget.store.box<Product>().getAll();
    List<DropdownMenuItem<Product>> finalList = [];
    for (Product prod in products) {
      var ddmi = DropdownMenuItem(child: Text(prod.name), value: prod);
      finalList.add(ddmi);
    }
    return finalList;
  }

  Widget _buildBrandName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Brand Name', hintText: 'Kimbo'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Name is required";
        }
        return null;
      },
      onSaved: (String? value) {
        brandName = value!;
      },
    );
  }

  Widget _buildQty() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Quantity Per pack",
        hintText: "0",
        suffixText: "Kg",
      ),
      onSaved: (String? value) {
        qtyPerPack = value!;
      },
      validator: (String? value) {
        var qty = double.tryParse(value!);
        if (qty == null || qty < 0) {
          return 'invalid!';
        }
        return null;
      },
    );
  }

  Widget _buildTotalNoOf() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Packs Available",
        hintText: "0",
        suffixText: "pack(s)",
      ),
      onSaved: (String? value) {
        totalPacksAvailable = value!;
      },
      validator: (String? value) {
        var total = double.tryParse(value!);
        if (total == null || total < 0) {
          return 'invalid!';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 0,
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.cyan[200],
        // ),
        width: MediaQuery.of(context).size.width * 0.3,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SimpleHeadline(text: "Add A Brand"),
                  const SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: prodList(),
                    value: product,
                    dropdownColor: Colors.deepPurple[100],
                    onChanged: (Product? newValue) {
                      setState(() {
                        product = newValue!;
                      });
                    },
                    validator: (Product? value) {
                      if (value == null) {
                        return "Select A Product";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (Product? value) {
                      product = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: "Choose a Product",
                      prefixText: "Product:  ",
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: const BorderSide(color: Color.fromARGB(255, 233, 16, 233), width: 2),
                      //   // borderRadius: BorderRadius.circular(20),
                      // ),
                      // border: OutlineInputBorder(
                      //   borderSide: const BorderSide(color: Color.fromARGB(255, 0, 62, 112), width: 2),
                      //   // borderRadius: BorderRadius.circular(20),
                      // ),
                      // filled: true,
                      // fillColor: Color.fromARGB(255, 102, 131, 181),
                    ),
                  ),
                  const SizedBox(height: 5),
                  _buildBrandName(),
                  const SizedBox(height: 5),
                  _buildQty(),
                  const SizedBox(height: 5),
                  _buildTotalNoOf(),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // if form is invalid
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      // else
                      _formKey.currentState!.save();
                      double qty = double.parse(qtyPerPack);
                      int totalPacks = int.parse(totalPacksAvailable);
                      PackagedProduct pkg = PackagedProduct(
                        qtyPerPack: qty,
                        totalAvailablePacks: totalPacks,
                        brandName: brandName,
                      );
                      pkg.product.target = product;
                      int PkgId = widget.store.box<PackagedProduct>().put(pkg);
                      Navigator.pop(context);
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddProduction extends StatefulWidget {
  final Store store;

  const AddProduction({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<AddProduction> createState() => _AddProductionState();
}

class _AddProductionState extends State<AddProduction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Product? product;
  RawMaterial? rm;
  List widgetList = [];

  List<DropdownMenuItem<Product>> prodList() {
    List products = widget.store.box<Product>().getAll();
    List<DropdownMenuItem<Product>> finalList = [];
    for (Product prod in products) {
      var ddmi = DropdownMenuItem(child: Text(prod.name), value: prod);
      finalList.add(ddmi);
    }
    return finalList;
  }

  List<DropdownMenuItem<RawMaterial>> rawMatList() {
    List rawMats = widget.store.box<RawMaterial>().getAll();
    List<DropdownMenuItem<RawMaterial>> finalList = [];
    for (RawMaterial rm in rawMats) {
      var ddmi = DropdownMenuItem(
        child: Text('${rm.name}.    Available stock: ${rm.quantity}'),
        value: rm,
      );
      finalList.add(ddmi);
    }
    return finalList;
  }

  Widget formField() => DropdownButtonFormField(
        items: rawMatList(),
        value: rm,
        dropdownColor: Colors.deepPurple[100],
        onChanged: (RawMaterial? newValue) {
          setState(() {
            rm = newValue!;
          });
        },
        validator: (RawMaterial? value) {
          if (value == null) {
            return "Select A Product";
          } else {
            return null;
          }
        },
        onSaved: (RawMaterial? value) {
          rm = value!;
        },
        decoration: const InputDecoration(
          hintText: "Pick Raw Material",
          prefixText: "Raw Material:  ",
        ),
      );

  @override
  void initState() {
    super.initState();
    Widget ff = formField();
    widgetList.add(ff);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      child: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SimpleHeadline(text: "Register Production"),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              items: prodList(),
              value: product,
              dropdownColor: Colors.deepPurple[100],
              onChanged: (Product? newValue) {
                setState(() {
                  product = newValue!;
                });
              },
              validator: (Product? value) {
                if (value == null) {
                  return "Select A Product";
                } else {
                  return null;
                }
              },
              onSaved: (Product? value) {
                product = value!;
              },
              decoration: const InputDecoration(
                hintText: "Choose a Product",
                prefixText: "Product:  ",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Raw Materials"),
                IconButton(
                  onPressed: () {
                    Widget gg = formField();
                    widgetList.add(gg);
                    setState(() {});
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            ...widgetList
          ],
        ),
      ),
    );
  }
}

addClientDialogue(BuildContext context, {required Store store}) {
  late String _name;
  late String _telNo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name', hintText: 'Makmende Aloice', prefixIcon: Icon(Icons.portrait)),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Name is required";
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildTelNo() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Telephone No.',
        prefixText: '+254 ',
        prefixIcon: Icon(Icons.numbers),
      ),
      maxLength: 9,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "telephone number required";
        }

        return null;
      },
      onSaved: (String? value) {
        _telNo = value!;
      },
    );
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SimpleHeadline(text: "Register New Client"),
                    const SizedBox(height: 20),
                    _buildName(),
                    const SizedBox(height: 20),
                    _buildTelNo(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // if form is invalid
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        // else
                        _formKey.currentState!.save();
                        Client person = Client(name: _name, telNo: _telNo);
                        store.box<Client>().put(person);
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

addProductDialogue(BuildContext context, {required Store store}) {
  late String _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget newProduct() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Product Name",
        hintText: "i.e. Unga",
      ),
      onSaved: (String? value) {
        _name = value!;
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Name is required";
        }
        return null;
      },
    );
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.card,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10,
            ),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 190,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SimpleHeadline(text: "Register New Product"),
                    const SizedBox(height: 20),
                    newProduct(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // if form is invalid
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        // else
                        _formKey.currentState!.save();
                        Product pr = Product(name: _name);
                        int prID = store.box<Product>().put(pr);
                        FinishedProduct fp = FinishedProduct(qtyInStock: 0);
                        fp.product.targetId = prID;
                        int fpID = store.box<FinishedProduct>().put(fp);
                        Navigator.pop(context);
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

addRawMaterialDialogue(BuildContext context, {required Store store}) {
  late String _name;
  late String _quantity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late int _price;

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Raw material",
        hintText: "i.e. Maize",
      ),
      onSaved: (String? value) {
        _name = value!;
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Name is required";
        }
        return null;
      },
    );
  }

  Widget _buildQty() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Quantity",
        hintText: "0",
        suffixText: "Kg",
      ),
      onSaved: (String? value) {
        _quantity = value!;
      },
      validator: (String? value) {
        var qty = double.tryParse(value!);
        if (qty == null || qty < 0) {
          return 'invalid!';
        }
        return null;
      },
    );
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.card,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10,
            ),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 250,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SimpleHeadline(text: "Register Raw Material"),
                    const SizedBox(height: 20),
                    _buildName(),
                    const SizedBox(height: 20),
                    _buildQty(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // if form is invalid
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        // else
                        _formKey.currentState!.save();
                        RawMaterial rm = RawMaterial(name: _name, quantity: double.parse(_quantity));
                        int rmID = store.box<RawMaterial>().put(rm);
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

addPkgMod(BuildContext context, {required Store store}) {
  return showModalBottomSheet(
    context: context,
    // elevation: 10,
    // constraints: Box,
    // enableDrag: true,
    builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddPkg(store: store),
        ],
      );
    },
  );
}
