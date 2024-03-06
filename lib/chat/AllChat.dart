
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../services/peer_user_model.dart';
import 'Chat.dart';
import 'package:shimmer/shimmer.dart';

import 'newFriendChat.dart';
import 'newWorkerChat.dart';


class MyChats extends StatefulWidget {
  const MyChats({Key? key}) : super(key: key);

  @override
  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats>  with SingleTickerProviderStateMixin{
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uId;
  List? id;
  String? peerId;
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    uId = getUid();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        selectedIndex = _tabController!.index;
      });
    });

  }

  String getUid() {
    final User? user = auth.currentUser;
    return user!.uid;
    // here you write the codes to input the data into firestore
  }

  int _limit = 20;
  final ScrollController listScrollController = ScrollController();
  bool isLoading = false;
  String messageIndex = "0" ;
  TabController? _tabController ;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Text("Chat"),
          iconTheme: IconThemeData(
            color: Colors.white, // Set the color of the back icon to white
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,

        ),
        body:DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffDCDCDC)),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: kPrimaryColor,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  /*indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 0.0, color: Colors.white),
                        insets: EdgeInsets.symmetric(horizontal: 16.0),
                      ),*/
                  tabs: [
                    Tab(text: 'Friends Chat'),
                    Tab(text: 'Worker Chat'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Friend chat
                    Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              // List
                              Container(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('chat group')
                                      .where(
                                    "id",
                                    arrayContains: uId,
                                  ).where("type" ,isEqualTo:"fellow",).orderBy('time',descending: true).snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    print("user Id $uId");

                                    if (snapshot.hasError) {
                                      print("error ${snapshot.error}");
                                      return Center(
                                        child: Column(
                                          children: [SelectableText("Something Went Wrong .")],
                                        ),
                                      );
                                    }
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(color: kPrimaryColor,),
                                      );
                                    }

                                    if (snapshot.data!.size != 0) {
                                      List<Offset> pointList = <Offset>[];

                                      return ListView.builder(
                                        padding: EdgeInsets.all(10.0),
                                        itemBuilder: (context, index) {
                                          print("user Id $uId");
                                          print("yes user has data ");
                                          DocumentSnapshot? document =  snapshot.data?.docs[index];

                                          //return buildItem(context, snapshot.data!.docs[index]);

                                          id = List.from(document!.get('id'));
                                          if (id![0] == uId) {
                                            peerId = id![1];
                                            print("user Id  :$uId");
                                            print("Peer Id : $peerId");
                                            return buildItem(context, snapshot.data!.docs[index]);
                                          }
                                          else if (id![1] == uId) {
                                            peerId = id![0];
                                            print("user Id  :$uId");
                                            print("Peer Id : $peerId");
                                            return buildItem(context, snapshot.data!.docs[index]);
                                          }
                                          else
                                          {
                                            return Container();
                                          }
                                        },
                                        itemCount: snapshot.data?.docs.length,
                                        controller: listScrollController,
                                      );
                                    } else if (snapshot.data!.size == 0) {
                                      print("user Id $uId");
                                      print("user data not found");
                                      return Center(
                                        child: Container(
                                          child: Text("No Previous Chat".tr()),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),

                              // Loading
                              Positioned(
                                child: isLoading ? const Loading() : Container(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Worker chat
                    Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              // List
                              Container(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('chat group')
                                      .where(
                                    "id",
                                    arrayContains: uId,
                                  ).where("type" ,isEqualTo:"cross",).orderBy('time',descending: true).snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    print("user Id $uId");

                                    if (snapshot.hasError) {
                                      print("error ${snapshot.error}");
                                      return Center(
                                        child: Column(
                                          children: [SelectableText("Something Went Wrong .")],
                                        ),
                                      );
                                    }
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(color: kPrimaryColor,),
                                      );
                                    }

                                    if (snapshot.data!.size != 0) {
                                      List<Offset> pointList = <Offset>[];

                                      return ListView.builder(
                                        padding: EdgeInsets.all(10.0),
                                        itemBuilder: (context, index) {
                                          print("user Id $uId");
                                          print("yes user has data ");
                                          DocumentSnapshot? document =  snapshot.data?.docs[index];

                                          id = List.from(document!.get('id'));
                                          if (id![0] == uId) {
                                            peerId = id![1];
                                            print("user Id  :$uId");
                                            print("Peer Id : $peerId");
                                            return buildItem(context, snapshot.data!.docs[index]);
                                          }
                                          else if (id![1] == uId) {
                                            peerId = id![0];
                                            print("user Id  :$uId");
                                            print("Peer Id : $peerId");
                                            return buildItem(context, snapshot.data!.docs[index]);
                                          }
                                          else
                                          {
                                            return Container();
                                          }
                                        },
                                        itemCount: snapshot.data?.docs.length,
                                        controller: listScrollController,
                                      );
                                    } else if (snapshot.data!.size == 0) {
                                      print("user Id $uId");
                                      print("user data not found");
                                      return Center(
                                        child: Container(
                                          child: Text("No Previous Chat".tr()),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),

                              // Loading
                              Positioned(
                                child: isLoading ? const Loading() : Container(),
                              )
                            ],
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            selectedIndex == 0 ?
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => NewFriendChat()))
                : Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>NewWorkerChat()));
            // Respond to button press
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async{
          print(document.get('id'));
          print(document.id);
          id = List.from(document.get('id'));
          if (id![0] == uId) {
            peerId = id![1];
            print("user Id  :$uId");
            print("Peer Id : $peerId");

          } else
          if (id![1] == uId) {
            peerId = id![0];
            print("user Id  :$uId");
            print("Peer Id : $peerId");

          }

          // bool dataLoaded = false;
          String name = "";

          // here name is being called just to send it to the chat for its appbar title and for that we are loooking for the index
          // if the index is 0 (Friend Chat) and 1 (Worker Chat)
          // Two sepereate functions are used just because worker and customer data is stored in two different collection in Firestore
          /*selectedIndex == 0 ?   name = await peerNameWorker(peerId.toString()):
          name = await peerNameCustomer(peerId.toString());



          selectedIndex == 0 ? Navigator.push(context,new MaterialPageRoute(builder: (context) => WorkerChat( peerId: peerId.toString(),name : name,))) :
          Navigator.push(context,new MaterialPageRoute(builder: (context) => FriendChat( peerId: peerId.toString(),name : name,)));*/

          // if the index is 0 (Friend Chat) and 1 (Worker Chat)
          String type = "";
          selectedIndex == 0 ? type = "fellow" : type = "cross" ;
          Navigator.push(context,new MaterialPageRoute(builder: (context) => Chat( peerId: peerId.toString(),type: type,)));

        },


        child: FutureBuilder<List<PeerUser>>(
          future: userData(selectedIndex),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
            {
              return Shimmer.fromColors(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 7, 7, 7),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),

                          Container(
                            width: 120,
                            height: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
              );

              //return Center(child: CircularProgressIndicator(color: kPrimaryColor));

            }
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.length > 0) {
                return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return  Divider(color: Colors.white,thickness: 3,);
                    },
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {

                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2,7,7,7),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data![index].profilePic),
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),

                                Expanded(
                                  child: Text(
                                    snapshot.data![index].username,

                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),




                                FutureBuilder<bool>(
                                  future : dataExist(snapshot.data![index].userId),
                                  builder: (context, snapshots1)
                                  {
                                    print("data snapshot");
                                    print("data  ${snapshots1.data}");
                                    print("Connnection  : ${snapshots1.connectionState}");
                                    if(snapshots1.connectionState == ConnectionState.waiting)
                                    {
                                      return CircularProgressIndicator(color: kPrimaryColor);
                                    }


                                    if(snapshots1.hasData && snapshots1.connectionState == ConnectionState.done)
                                    {
                                      print("data exisit ${snapshots1.data}");
                                      if(snapshots1.data == true)
                                      {
                                        return StreamBuilder<DocumentSnapshot>(
                                          stream:  FirebaseFirestore.instance.collection('unseen Message').doc(uId).collection('unseen Message').doc(snapshot.data![index].userId).snapshots() ,
                                          builder: ( BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshots){
                                            if(snapshots.data != null )
                                            {
                                              if(snapshots.data!['unseen'] == 0)
                                              {
                                                Container();
                                              }
                                              else
                                              {
                                                if(snapshots.data!['unseen'] >= 100)
                                                {
                                                  return Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: kPrimaryColor
                                                    ),
                                                    child: Center(child: Text("99+",style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold
                                                    ),),),
                                                  );
                                                }
                                                else
                                                {
                                                  return Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: kPrimaryColor
                                                    ),
                                                    child: Center(child: Text(snapshots.data!['unseen'].toString(),style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold
                                                    ),),),
                                                  );

                                                }
                                              }



                                            }

                                            return Container();
                                          },
                                        );
                                      }
                                      else
                                      {
                                        return Container();
                                      }

                                    }
                                    else if (snapshots1.data == null)
                                    {
                                      return CircularProgressIndicator(color: kPrimaryColor);
                                    }
                                    else
                                    {
                                      return Container();
                                    }
                                  },
                                ),


/*
                                messageIndex == "0" ? Container() : ,
*/
                              ],
                            ),
                            Divider(
                              height: 1,
                              indent: 70,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      );
                    });
              }
              else {
                print(snapshot.hasData);
                print(snapshot.connectionState);
                print(snapshot.error);
                print(snapshot.data!.length);
                return  Center(
                  child: Container(
                      child: Text("No Chat").tr()),
                );
              }
            } else if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            } else {
              return new Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
          },
        ),
      ),
    );
  }

  Future indexMessage (String peer) async {

    CollectionReference users = FirebaseFirestore.instance.collection('unseen Message');
    users.doc(uId).collection('unseen Message').doc(peer).get().then((DocumentSnapshot documentSnapshot) {
      if(documentSnapshot.exists)
      {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        print("Message index is : ${data['unseen']}");

        if(data['unseen'] == 0)
        {
          messageIndex = "0";

        }
        else
        {
          if(data['unseen']>= 100)
          {
            messageIndex = "99+";
          }
          else
          {
            messageIndex = data['unseen'].toString();
          }
        }
      }
      else
      {
        print("No data");
        messageIndex = "0";
      }

    });
  }

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////These Two FUNC are Used to just send name to Chat Screen ///////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
  Future<String> peerNameWorker(String id) async {
    var name = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          name = documentSnapshot.get('name');
        });
      }
    });

    return name;

  }

  Future<String> peerNameCustomer(String id) async {
    var name = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          name = documentSnapshot.get('name');
        });
      }
    });

    return name;

  }
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////


  Future<bool> dataExist(String uid) async  {
    bool? exsist  ;
    try {
      print("No Error");
      await FirebaseFirestore.instance.collection('unseen Message').doc(uId).collection('unseen Message').doc(uid).get().then((doc) {
        print(doc.exists);
        exsist = doc.exists;

      });
    } catch (e) {
      print("error fetching");
      exsist =  false;
    }

    return exsist ?? false;

  }

  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  /////////////// This User Data code returns List ////////////////////////
  /////////////// But have a single document of Data //////////////////////
  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  Future<List<PeerUser>> userData(int tabViewIndex) async {
    List<PeerUser> list = [];
    DocumentReference usersCollection;

    // Here, the IF-ELSE statement is used to determine the collection based on the tabViewIndex
    if (tabViewIndex == 0) {
      usersCollection = FirebaseFirestore.instance.collection('customer').doc(peerId);
      print("Customer collection selected");
    } else {
      usersCollection = FirebaseFirestore.instance.collection('users').doc(peerId);
      print("User collection selected");
    }

    DocumentSnapshot documentSnapshot = await usersCollection.get();
    if (documentSnapshot.exists) {
      PeerUser model = PeerUser(
        documentSnapshot.id.toString(),
        documentSnapshot.get('name'),
        documentSnapshot.get('profileUrl'),
      );
      print("========");
      print("name is ${model.username}");
      print("profileUrl is ${model.profilePic}");
      print("doc id is ${model.userId}");
      list.add(model);
    }

    return list;
  }

}

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}


