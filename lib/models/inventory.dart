import 'package:objectbox/objectbox.dart';

// import 'package:first_run/objectbox.g.dart';

@Entity()
class Product {
  int id;
  String name;

  @Backlink()
  final productions = ToMany<Production>();

  Product({
    this.id = 0,
    required this.name,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

@Entity()
class RawMaterial {
  int id;
  String name;
  double quantity;
  int? price;

  @Backlink()
  final productions = ToMany<Production>();

  RawMaterial({
    this.id = 0,
    required this.name,
    required this.quantity,
    this.price,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RawMaterial && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

@Entity()
class Production {
  int id;
  final DateTime day = DateTime.now();
  final product = ToOne<Product>();
  final rawMaterials = ToMany<RawMaterial>();

  Production({
    this.id = 0,
  });
}

@Entity()
class PackagedProduct {
  int id;
  String brandName;
  double qtyPerPack;
  int totalAvailablePacks;

  final product = ToOne<Product>();

  PackagedProduct({
    this.id = 0,
    required this.qtyPerPack,
    required this.totalAvailablePacks,
    required this.brandName,
  });
}

@Entity()
class FinishedProduct {
  int id;
  int qtyInStock;

  final product = ToOne<Product>();

  FinishedProduct({
    this.id = 0,
    required this.qtyInStock,
  });
}

@Entity()
class Client {
  int id;
  String name;
  String telNo;
  int credit = 0;
  int debit = 0;

  @Backlink()
  final myBuys = ToMany<InTransaction>();

  @Backlink()
  final mySells = ToMany<OutTransaction>();

  Client({
    this.id = 0,
    required this.name,
    required this.telNo,
  });
}

@Entity()
class InTransaction {
  int id;
  int totalCost;
  int paidAmount;
  int? debt;

  final client = ToOne<Client>();
  final pkgProducts = ToMany<PackagedProduct>();

  InTransaction({
    this.id = 0,
    required this.totalCost,
    required this.paidAmount,
    required this.debt,
  });
}

@Entity()
class OutTransaction {
  int id;
  int totalCost = 0;
  int paidAmount = 0;
  int? debt;

  final client = ToOne<Client>();
  final rawMaterials = ToMany<RawMaterial>();

  OutTransaction({
    this.id = 0,
  });

  void finalizePayment({required int amountPaid}) {
    int total = 0;

    for (var element in rawMaterials) {
      if (element.price != null) {
        total += element.price!;
      }
    }

    totalCost = total;
    if (amountPaid < totalCost) {
      debt = totalCost - amountPaid;
    }
  }
}
