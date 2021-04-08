import 'package:flutter/material.dart';

class ListDev extends StatefulWidget {
  final List<Product> _productList = List.filled(0, null, growable: true);
  ListDev() {
    this._productList.add(new Product("123456", "Молоко Ряжанка"));
    this._productList.add(new Product("346234", "Молоко Селянське"));
    this._productList.add(new Product("754359", "Молоко Молокія"));
    this._productList.add(new Product("482012", "Молоко Словяночка"));
  }

  @override
  ListDevState createState() => ListDevState(_productList);
}

class Product {
  String code;
  String title;
  String review = '';
  Product(this.code, this.title);
}

class ListDevState extends State<ListDev> {
  List<Product> _productList = List.filled(0, null, growable: true);
  final _formKey = GlobalKey<FormState>();
  final _formKeyReview = GlobalKey<FormState>();
  String newProductCode = '';
  String newProductTitle = '';
  String newProductReview = '';
  final String newProductReviewNull = 'Відгуку поки немає';

  ListDevState(this._productList);

  void _addProduct(Product product) {
    setState(() {
      this._productList.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: this._productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${this._productList[index].title}\n${this._productList[index].review == '' ? newProductReviewNull : this._productList[index].review}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        }),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'Штрихкод: \n${this._productList[index].code}\n${this._productList[index].title}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              height: 1
                            ),
                          ),
                        ),
                      )
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    flex: 1,
                      child: Container(
                        height: 87,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 0.1,
                              spreadRadius: 0.0, 
                              offset: Offset(
                                0.0,
                                1.0, 
                              ),
                            )
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.rate_review_rounded),
                          tooltip: 'Залишити відгук',
                          onPressed: () => setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKeyReview,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                onSaved: (String value) {
                                                  newProductReview = value;
                                                },
                                                decoration:
                                                  const InputDecoration(
                                                    labelText: 'Відгук',
                                                  ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Введіть значення';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                child: Text("Додати відгук"),
                                                onPressed: () {
                                                  if (_formKeyReview.currentState.validate()) {
                                                    _formKeyReview.currentState.save();
                                                    int ind = _productList.indexWhere((el) => el.code == this._productList[index].code);
                                                    setState(() {
                                                      this._productList[ind].review = newProductReview;
                                                    });
                                                    Navigator.pop(context, false);
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            );
                          }),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 87,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 0.1,
                              spreadRadius: 0.0, 
                              offset: Offset(
                                0.0,
                                1.0, 
                              ),
                            )
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Видалити продукт',
                          onPressed: () {
                            int ind = _productList.indexWhere((el) => el.code == this._productList[index].code);
                            setState(() {
                              this._productList.removeAt(ind);
                            });
                          },
                        ),
                      )
                    ),
                  ],
                )
              );
            }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                onSaved: (String value) {
                                  newProductCode = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Штрихкод',
                                ),
                                validator: (value) {
                                  int ind = _productList
                                      .indexWhere((el) => el.code == value);
                                  if (value == null || value.isEmpty) {
                                    return 'Введіть значення';
                                  } else if (ind != -1) {
                                    return 'Даний штрихкод зайнятий';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                onSaved: (String value) {
                                  newProductTitle = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Назва',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Введіть значення';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text("Додати продукт"),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    _addProduct(new Product(
                                        newProductCode, newProductTitle));
                                    Navigator.pop(context, false);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }),
        tooltip: 'Додати продукт',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
