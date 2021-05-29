import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Delivery',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  String nombre = "";
  String pedido = "";
  String mensaje = "";
  double precio = 0;
  int cantidad = 0;
  bool delivery = false;
  bool validacion = false;
  double totalPagar = 0;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tfNombre = TextEditingController();
  final _tfPedido = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();

  void calcular() {
    setState(() {
      widget.validacion = false;
      if (_tfNombre.text.toString() == "" ||
          _tfPrecio.text.toString() == "" ||
          _tfPedido.text.toString() == "" ||
          _tfCantidad.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "Campos no pueden ser vacios";
        return;
      }

      // widget.nombre = _tfNombre.text.text();
      widget.precio = double.parse(_tfPrecio.text);
      widget.cantidad = int.parse(_tfCantidad.text);

      widget.totalPagar = (widget.precio * widget.cantidad);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
                "Bienvenido por favor completa sus datos para completar el pedido",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _tfNombre,
                  decoration: InputDecoration(
                    hintText: "Nombres",
                    labelText: "Nombres",
                    errorText:
                        _tfPrecio.text.toString() == "" ? widget.mensaje : null,
                  ),
                ),
                TextField(
                  controller: _tfPedido,
                  decoration: InputDecoration(
                    hintText: "Pedido",
                    labelText: "Pedido",
                    errorText:
                        _tfPrecio.text.toString() == "" ? widget.mensaje : null,
                  ),
                ),
                TextField(
                  controller: _tfPrecio,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: "Precio",
                    labelText: "Precio",
                    errorText:
                        _tfPrecio.text.toString() == "" ? widget.mensaje : null,
                  ),
                ),
                TextField(
                  controller: _tfCantidad,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: "Cantidad",
                    labelText: "Cantidad",
                    errorText:
                        _tfPrecio.text.toString() == "" ? widget.mensaje : null,
                  ),
                ),
                Text(
                  "Total " + widget.totalPagar.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text("Delivery"),
                Switch(
                    value: widget.delivery,
                    onChanged: (bool s) {
                      setState(() {
                        widget.delivery = s;
                        if (widget.delivery = true) {
                          widget.totalPagar = widget.totalPagar + 20;
                        } else {
                          widget.precio = 0;
                        }
                      });
                    }),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 200, horizontal: 10),
              child: Column(children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Helvet",
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    calcular();
                  },
                )
              ]))
        ],
      ),
    );
  }
}
