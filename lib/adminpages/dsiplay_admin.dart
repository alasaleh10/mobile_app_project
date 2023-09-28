import 'package:flutter/material.dart';
import 'package:mobile_app_project/adminpages/editcar.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';

import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';

class display_admin extends StatefulWidget {
  const display_admin({super.key});

  @override
  State<display_admin> createState() => _display_adminState();
}

class _display_adminState extends State<display_admin> with curd {
  getdata() async {
    var response = await getRequest(displaycarsserver);
    return response;
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: getdata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status'] == 'filed') {
                  return Center(
                    child: text(titile: 'لايوجد سيارات'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(13),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: prime_contenercolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                text(
                                    titile:
                                        '${snapshot.data['data'][index]['car_name']}'),
                                SizedBox(
                                  height: 25,
                                ),
                                text(
                                    titile:
                                        '${snapshot.data['data'][index]['car_discription']}الوصف'),
                                SizedBox(
                                  height: 20,
                                ),
                                text(
                                    titile:
                                        '${snapshot.data['data'][index]['car_price']}  السعر '),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: (() async {
                                        var response =
                                            await postRequst(deletecarserver, {
                                          'id': snapshot.data['data'][index]
                                                  ['car_id']
                                              .toString(),
                                          'imagename': snapshot.data['data']
                                              [index]['car_image']
                                        });
                                        setState(() {});
                                        print(response);
                                      }),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: (() {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) {
                                            return editcar(
                                              id: snapshot.data['data'][index]
                                                  ['car_id'],
                                              dis: snapshot.data['data'][index]
                                                  ['car_discription'],
                                              price: snapshot.data['data']
                                                      [index]['car_price']
                                                  .toString(),
                                            );
                                          })));
                                        }),
                                        icon: Icon(Icons.edit))
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                text(
                                    titile:
                                        '${snapshot.data['data'][index]['car_rental']}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ClipRRect(
                                    child: Image.network(
                                      '$carsimages/${snapshot.data['data'][index]['car_image']}',
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              return Center(
                child: text(titile: 'Error'),
              );
            },
          ),
          Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: primecolore,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ))),
          Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: primecolore,
                    child: Icon(
                      Icons.update,
                      color: Colors.black,
                    ),
                  )))
        ],
      ),
    );
  }
}
