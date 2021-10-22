import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: LoginPage());
    //title: 'DIF HUIXQUILUCAN',
    //theme: new ThemeData(
    //primarySwatch: Colors.blue,
    //),
    //home: new ImageTile(list: categories),
    //);
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'DIF HUIXQUILUCAN',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre de Usuario',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Iniciar Sesión'),
                      onPressed: () {
                        var bytes1 = utf8.encode(
                            passwordController.text); // data being hashed
                        var digest1 = sha256.convert(bytes1);
                        print(nameController.text);
                        print(digest1);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoriesScreen(list: categories)));
                      },
                    )),
              ],
            )));
  }
}

var categories = [
  "Educación",
  "Salud",
  "Atención al Adulto Mayor",
  "Atención Jurídica",
  "Departamento de Capacitación a la Mujer",
  "Comedor Infantil",
  "Actividad Física",
];

var subCategories = [
  "Estancias Infantiles",
  "Jardín de Niños",
  "Prepa DIF",
  "Aulas Móviles"
];

var services = [
  "DIF Central",
  "Pirules",
  "San Fernando",
  "Jesús del monte",
  "Zacamulpa",
  "San Bartolomé Coatepec",
  "La Glorieta",
  "Magdalena Chichicaspa"
];

List<Widget> _tiles = <Widget>[
  for (var i in categories)
    InkWell(
      child: Container(
          child: Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(i,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20))),
          ),
          decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          )),
      onTap: () {
        print(i);
      },
    ),
];

// counts the level of screens: 0 = Home Screen, 1 = Subcatogories, 2 = Services
var counterScreens = 0;

class CategoriesScreen extends StatelessWidget {
  final List<String> list;

  const CategoriesScreen({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Términos y Condiciones'),
            onTap: () {
              print("terms");
            },
          ),
        ]),
      ),
      appBar: new AppBar(
        title: new Text('DIF HUIXQUILUCAN'),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            for (var i in list)
              InkWell(
                child: Container(
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(i,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                    )),
                onTap: () {
                  switch (counterScreens) {
                    case 0:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubcategoriesScreen(
                                  list: subCategories, category: i)));
                      counterScreens++;
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ServicesScreen(list: services, subCategory: i)));
                      counterScreens++;
                      break;
                    default:
                      break;
                  }
                },
              ),
          ],
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

class SubcategoriesScreen extends StatelessWidget {
  final String category;
  final List<String> list;

  const SubcategoriesScreen({
    Key? key,
    required this.list,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            counterScreens--;
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(child: CategoriesScreen(list: list)),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  final String subCategory;
  final List<String> list;

  const ServicesScreen({
    Key? key,
    required this.list,
    required this.subCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(subCategory),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            counterScreens--;
            Navigator.pop(context);
          },
        ),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 2.0,
          children: <Widget>[
            for (var i in list)
              InkWell(
                child: Container(
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(i,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(service: i)));
                },
              ),
          ],
        ),
      ),
    );
  }
}

Future<ServiceRequest> fetchServiceRequest() async {
  final response = await http
      .get(Uri.parse('http://52.207.255.109:5000/servicio/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return parseServiceDetail(response.body);
    return ServiceRequest.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load information');
  }
}

class ServiceRequest {
  final ServiceDetail one;
  final ServiceDetail two;
  final ServiceDetail three;

  ServiceRequest({
    required this.one,
    required this.two,
    required this.three,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
        one: ServiceDetail.fromJson(json["0"]),
        two: ServiceDetail.fromJson(json["1"]),
        three: ServiceDetail.fromJson(json["2"])
    );
  }
}

class ServiceDetail {
  final int idServicio;
  final String direccion;
  final String descripcion;
  final int fechaPublicacion;
  final int fechaVencimiento;
  final double cuota;
  final String imagen;
  final String subcategoria;
  final int fechaCreacion;
  final int fechaModificacion;

  ServiceDetail ({
    required this.idServicio,
    required this.direccion,
    required this.descripcion,
    required this.fechaPublicacion,
    required this.fechaVencimiento,
    required this.cuota,
    required this.imagen,
    required this.subcategoria,
    required this.fechaCreacion,
    required this.fechaModificacion
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
    return ServiceDetail(
        idServicio: json["idServicio"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
        fechaPublicacion: json["fechaPublicacion"],
        fechaVencimiento: json["fechaVencimiento"],
        cuota: json["cuota"],
        imagen: json["imagen"],
        subcategoria: json["subcategoria"],
        fechaCreacion: json["fecha_creacion"],
        fechaModificacion: json["fechaModificacion"]
    );
  }
}

class ServiceDetailScreen extends StatelessWidget {
  final String service;
  late Future<ServiceRequest> serviceDetails;

  ServiceDetailScreen({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    serviceDetails = fetchServiceRequest();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(service),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: FutureBuilder<ServiceRequest>(
            future: fetchServiceRequest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    // descripción
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(snapshot.data!.one.descripcion,
                          textAlign: TextAlign.justify),
                    ),
                    // ubicación
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(snapshot.data!.one.direccion),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text("Cuota:   " + snapshot.data!.one.cuota.toString()),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Image.network("https://difhuixquilucan.gob.mx/wp-content/uploads/2020/03/logoDif.png"),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
        /*child: Column(
          children: [
            // desc
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('Descripción: Niños y niñas de la comunidad de Santiago Yancuitlalpan pueden acudir al Comedor Infantil, en donde recibirán una alimentación balanceada, además todo el servicio se brinda bajo las medidas de higiene adecuadas para proteger la salud de los pequeños y sus familias. Para inscribirte y solicitar información puedes acudir directamente de 12:30 a 15:00 horas',
              textAlign: TextAlign.justify),
            ),
            // ubicación
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('Dirección: '),
              alignment: Alignment.topLeft,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('Cuota: '),
              alignment: Alignment.topLeft,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('Contacto: '),
              alignment: Alignment.topLeft,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
          ],
        ),*/
      ),
    );
  }
}
