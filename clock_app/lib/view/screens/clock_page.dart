import 'dart:math';
import 'package:clock_app/view/components/clock_option_tile.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime d = DateTime.now();
  bool _isAnalog = true;
  bool _isStrap = false;
  bool _isDigital = false;
  bool _image = true;

  final List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  final List<String> weekday = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  void startClock() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        d = DateTime.now();
      });
      startClock();
    });
  }

  @override
  void initState() {
    super.initState();
    startClock();
  }

  final List<String> _bgImages = [
    "https://static.vecteezy.com/system/resources/thumbnails/001/849/553/small_2x/modern-gold-background-free-vector.jpg",
    "https://i.pinimg.com/736x/3d/ec/44/3dec44c989d642633f812dad12a2e010.jpg",
    "https://static.vecteezy.com/system/resources/previews/011/208/814/original/technology-background-analog-clock-time-vector.jpg",
  ];
  int _selectedImage = 0;

  final List<DateTime> _flaggedTimes = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clock Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: () {
              setState(() {
                _flaggedTimes.add(DateTime.now());
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _flaggedTimes.clear();
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://edug.in/panel/head_admin/School/school_head/first_photo/DEMO59167.jpg"),
              ),
              accountName: Text("Demo account"),
              accountEmail: Text("dummy@mail.io"),
            ),
            clockOptionTile(
              title: "Analog clock",
              val: _isAnalog,
              onChanged: (val) => setState(
                () => _isAnalog = !_isAnalog,
              ),
            ),
            clockOptionTile(
              title: "Strap clock",
              val: _isStrap,
              onChanged: (val) => setState(
                () => _isStrap = !_isStrap,
              ),
            ),
            clockOptionTile(
              title: "Digital clock",
              val: _isDigital,
              onChanged: (val) => setState(
                () => _isDigital = !_isDigital,
              ),
            ),
            clockOptionTile(
              title: "Image",
              val: _image,
              onChanged: (val) => setState(() => _image = !_image),
            ),
            Visibility(
              visible: _image,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _bgImages.map((e) {
                    int index = _bgImages.indexOf(e);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = index;
                        });
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: index == _selectedImage
                              ? Border.all(color: Colors.grey)
                              : null,
                          image: DecorationImage(
                            image: NetworkImage(e),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: _image
              ? DecorationImage(
                  image: NetworkImage(_bgImages[_selectedImage]),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: size.height * 0.63,
              width: size.height * 0.63,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLzsfu-puj9PytAg641aJuRl5D8fjCD7WoBQ&s",
                    ),
                    fit: BoxFit.contain),
              ),
            ),
            Visibility(
              visible: _isAnalog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(60, (index) {
                    return Transform.rotate(
                      angle: index * (pi * 2) / 60,
                      child: Divider(
                        endIndent: index % 5 == 0
                            ? size.width * 0.88
                            : size.width * 0.9,
                        thickness: 2,
                        color: index % 5 == 0 ? Colors.red : Colors.black,
                      ),
                    );
                  }),
                  // Hour Hand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.hour * (pi * 2) / 12,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 4,
                      ),
                    ),
                  ),
                  //Minute Hand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.minute * (pi * 2) / 60,
                      child: Divider(
                        indent: 30,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ),
                  // Second Hand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.second * (pi * 2) / 60,
                      child: Divider(
                        indent: 20,
                        endIndent: size.width * 0.89 - 16,
                        color: Colors.red,
                        thickness: 4,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isStrap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 9,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      value: d.hour / 12,
                    ),
                  ),
                  Transform.scale(
                    scale: 7,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.3,
                      value: d.minute / 60,
                    ),
                  ),
                  Transform.scale(
                    scale: 4,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      value: d.second / 60,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isDigital,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${month[d.month - 1]}, ${weekday[d.weekday - 1]} ${d.day.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${d.hour} : ${d.minute} : ${d.second}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              child: Column(
                children: _flaggedTimes.map((time) {
                  return Text(
                    "${time.hour}:${time.minute}:${time.second}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
