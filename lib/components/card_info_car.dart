import 'package:flutter/material.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/client/home_page_client.dart';

import 'package:unsplash_client/unsplash_client.dart';

import '../client/edit_car.dart';

class CardInfoCar extends StatefulWidget {
  final Car car;
  final Client client;
  const CardInfoCar({required this.car, required this.client, super.key});

  @override
  State<CardInfoCar> createState() => _CardInfoCarState();
}

class _CardInfoCarState extends State<CardInfoCar> {
  Future<String> getImageUnsplash() async {
    // get a random photo
    final client = UnsplashClient(
      settings: const ClientSettings(
          credentials: AppCredentials(
        accessKey: 'rqwf_U-7jPNYHiuB_p46zrrQy0YuqkznOF1kGy2uAuc',
        secretKey: '7vEgYfg10Wni_b4yj7lwV5kSC4lvzg8RsZG7cTDiO8E',
      )),
    );
    // Call `goAndGet` to execute the [Request] returned from `random`
// and throw an exception if the [Response] is not ok.
    final carToSearch = '${widget.car.brand} ${widget.car.model}';
    //final carToSearch = 'toyota corolla';
    final photos = await client.search.photos(carToSearch).goAndGet();

// The api returns a `Photo` which contains metadata about the photo and urls to download it.
    final photo = photos.results.first;
    return photo.urls.regular.toString();
  }

  late Future<String> imageUrl;
  @override
  void initState() {
    super.initState();
    imageUrl = getImageUnsplash();
    debugPrint('imageUrl: $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion de su Automovil'),
        backgroundColor: Colors.orange.shade500,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
            child: Text(
              'Su Automovil',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    'Modelo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.car.model),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Marca',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.car.brand),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Año',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.car.carYear),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<String>(
                future: imageUrl,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(
                      snapshot.data!,
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error loading image');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const Text(
                'Placas',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.car.licencePlate),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        'Kilometraje',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('${widget.car.kilometers}'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Text(
                        'Ultimo servicio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(widget.car.lastService),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                    text: 'Editar',
                    textColor: Colors.white,
                    btnColor: Colors.blue,
                    fontSize: 18,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return EditCar(
                              car: widget.car,
                              client: widget.client,
                            );
                          },
                        ),
                      );
                    }),
                const SizedBox(
                  width: 10,
                  height: 25,
                ),
                RoundedButton(
                    text: 'Eliminar',
                    textColor: Colors.white,
                    btnColor: Colors.red,
                    fontSize: 18,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Eliminar automóvil'),
                            content: const Text(
                                '¿Está seguro de que desea eliminar este automóvil?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  dbHelper.deleteCar(widget.car.id);
                                  if (mounted) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return HomePageClient(
                                              client: widget.client);
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
