import 'package:flutter/material.dart';

void main() {
  runApp(MenuOffice());
}

class MenuOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Menú Delivery'),
    );
  }
}

// ignore: must_be_immutable
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
  double subtotal = 0;
  double descuento = 0;

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
      //Vales negativos y en 0
      widget.validacion = false;
      widget.subtotal = 0;
      widget.totalPagar = 0;
      widget.descuento = 0;

      //Validacion
      if (_tfNombre.text.toString() == "" ||
          _tfPrecio.text.toString() == "" ||
          _tfPedido.text.toString() == "" ||
          _tfCantidad.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "Campos no pueden ser vacios";
        return;
      }
      //Pamos los valores
      widget.precio = double.parse(_tfPrecio.text);
      widget.cantidad = int.parse(_tfCantidad.text);
      widget.subtotal = (widget.precio * widget.cantidad) + widget.descuento;

      //Comparamos si cumple las condiciones para descuento
      if (widget.subtotal > 500) {
        widget.descuento = widget.subtotal * 0.05;
      } else {
        widget.descuento = 0;
      }
      //Configuramos el valor que tendra el switch
      if (widget.delivery) {
        widget.totalPagar = (widget.subtotal + 20) - widget.descuento;
      } else {
        widget.totalPagar = widget.subtotal - widget.descuento;
      }
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sub Total:" + widget.subtotal.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Descuento:" + widget.descuento.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Delivery",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Switch(
                  value: widget.delivery,
                  onChanged: (value) {
                    setState(() {
                      widget.delivery = value;
                    });
                  },
                  activeColor: Colors.blueAccent,
                  inactiveThumbColor: Colors.black54,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
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
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total a Pagar:" + widget.totalPagar.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      backgroundColor: Colors.blue[50],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
