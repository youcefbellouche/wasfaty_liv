import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/filter.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Card/Rev_OrderCard.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

class Rev_historique extends StatefulWidget {
  @override
  _Rev_historiqueState createState() => _Rev_historiqueState();
}

class _Rev_historiqueState extends State<Rev_historique> {
  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _searchQuery = new TextEditingController();
  String orderId;

  final _sortByOptions = [
    SortBy("all", "Tout", "asc"),
    SortBy("terminer", "Terminer", "asc"),
    SortBy("annuler", "Annuler", "asc"),
  ];
  String value;
  String filtre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Rev_Drawer(),
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        openDrawer,
        Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchQuery,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.search),
                        hintText: "N° de Commande",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                        fillColor: Color(0xffe6e6ec),
                        filled: true,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          orderId = value;
                        }
                      },
                    ),
                  ),
                  PopupMenuButton(
                      onSelected: (sortBy) {
                        setState(() {
                          filtre = sortBy;
                          print(sortBy);
                        });
                      },
                      icon: Icon(Icons.tune),
                      itemBuilder: (BuildContext context) {
                        return _sortByOptions.map((item) {
                          return PopupMenuItem(
                              value: item.value,
                              child: Container(child: Text(item.text)));
                        }).toList();
                      })
                ],
              ),
            ),
            filtre == null || filtre.contains("all")
                ? FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("Commande")
                        .where("livreurId",
                            isEqualTo: FirebaseAuth.instance.currentUser.uid)
                        .where("OrderId",
                            isGreaterThanOrEqualTo: _searchQuery.text)
                        .get(),
                    builder: (context, snapshot1) {
                      return !snapshot1.hasData
                          ? Center(child: CircularProgressIndicator())
                          : FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("Commande_etr")
                                  .where("livreurId",
                                      isEqualTo:
                                          FirebaseAuth.instance.currentUser.uid)
                                  .where("OrderId",
                                      isGreaterThanOrEqualTo: _searchQuery.text)
                                  .get(),
                              builder: (context, snapshot2) {
                                return !snapshot2.hasData
                                    ? Center(child: CircularProgressIndicator())
                                    : snapshot2.data.docs.length == 0 &&
                                            snapshot1.data.docs.length == 0
                                        ? Center(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                Rev_RoundButton(
                                                  isfile: false,
                                                  image: "assets/vide.png",
                                                ),
                                                Text(
                                                  'Vous n\'avez pas de commande',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              ]))
                                        : SingleChildScrollView(
                                            child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot1.data.docs.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  Order model1 = Order.fromJson(
                                                      snapshot1.data.docs[index]
                                                          .data());
                                                  return Rev_OrderCard(
                                                    order: model1,
                                                    collection: "Commande",
                                                  );
                                                },
                                              ),
                                              ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot2.data.docs.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  Order model2 = Order.fromJson(
                                                      snapshot2.data.docs[index]
                                                          .data());
                                                  return Rev_OrderCard(
                                                    order: model2,
                                                    collection: "Commande_etr",
                                                  );
                                                },
                                              ),
                                            ],
                                          ));
                              },
                            );
                    },
                  )
                : _searchQuery.text.isEmpty
                    ? FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("Commande")
                            .where("livreurId",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser.uid)
                            .where("status", isEqualTo: filtre)
                            .get(),
                        builder: (context, snapshot1) {
                          return !snapshot1.hasData
                              ? Center(child: CircularProgressIndicator())
                              : FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection("Commande_etr")
                                      .where("livreurId",
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser.uid)
                                      .where("status", isEqualTo: filtre)
                                      .get(),
                                  builder: (context, snapshot2) {
                                    return !snapshot2.hasData
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : snapshot2.data.docs.length == 0 &&
                                                snapshot1.data.docs.length == 0
                                            ? Center(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                    Rev_RoundButton(
                                                      isfile: false,
                                                      image: "assets/vide.png",
                                                    ),
                                                    Text(
                                                      'Vous n\'avez pas de commande',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ]))
                                            : SingleChildScrollView(
                                                child: ListView(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                children: [
                                                  ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: snapshot1
                                                        .data.docs.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Order model1 =
                                                          Order.fromJson(
                                                              snapshot1.data
                                                                  .docs[index]
                                                                  .data());
                                                      return Rev_OrderCard(
                                                        order: model1,
                                                        collection: "Commande",
                                                      );
                                                    },
                                                  ),
                                                  ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: snapshot2
                                                        .data.docs.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Order model2 =
                                                          Order.fromJson(
                                                              snapshot2.data
                                                                  .docs[index]
                                                                  .data());
                                                      return Rev_OrderCard(
                                                        order: model2,
                                                        collection:
                                                            "Commande_etr",
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ));
                                  },
                                );
                        },
                      )
                    : FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("Commande")
                            .where("livreurId",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser.uid)
                            .where("OrderId",
                                isGreaterThanOrEqualTo: _searchQuery.text)
                            .where("status", isEqualTo: filtre)
                            .get(),
                        builder: (context, snapshot1) {
                          return !snapshot1.hasData
                              ? Center(child: CircularProgressIndicator())
                              : FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection("Commande_etr")
                                      .where("livreurId",
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser.uid)
                                      .where("OrderId",
                                          isGreaterThanOrEqualTo:
                                              _searchQuery.text)
                                      .where("status", isEqualTo: filtre)
                                      .get(),
                                  builder: (context, snapshot2) {
                                    return !snapshot2.hasData
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : snapshot2.data.docs.length == 0 &&
                                                snapshot1.data.docs.length == 0
                                            ? Center(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                    Rev_RoundButton(
                                                      isfile: false,
                                                      image: "assets/vide.png",
                                                    ),
                                                    Text(
                                                      'Vous n\'avez pas de commande',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ]))
                                            : SingleChildScrollView(
                                                child: ListView(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                children: [
                                                  ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: snapshot1
                                                        .data.docs.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Order model1 =
                                                          Order.fromJson(
                                                              snapshot1.data
                                                                  .docs[index]
                                                                  .data());
                                                      return Rev_OrderCard(
                                                        order: model1,
                                                        collection: "Commande",
                                                      );
                                                    },
                                                  ),
                                                  ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: snapshot2
                                                        .data.docs.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Order model2 =
                                                          Order.fromJson(
                                                              snapshot2.data
                                                                  .docs[index]
                                                                  .data());
                                                      return Rev_OrderCard(
                                                        order: model2,
                                                        collection:
                                                            "Commande_etr",
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ));
                                  },
                                );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
