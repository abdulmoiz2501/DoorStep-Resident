import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/peer_user_model.dart';
import 'Chat.dart';

class NewWorkerChat extends StatefulWidget {
  const NewWorkerChat({Key? key}) : super(key: key);

  @override
  State<NewWorkerChat> createState() => _NewWorkerChatState();
}

class _NewWorkerChatState extends State<NewWorkerChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,

        title: Text(
          'New Worker Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back icon to white
        ),

      ),
      body: Column(
        children: [


          FutureBuilder<List<PeerUser>>(
            future: userData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.length > 0) {
                  return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return  Divider(color: Colors.white,thickness: 3,);
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Chat(peerId: snapshot.data![index].userId,type: "cross")));

                            },
                            child: Container(
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
                            ),
                          ),
                        );

                      });
                }
                else {
                  return  Container(
                      height: MediaQuery.of(context).size.height*0.9,
                      child: Center(
                          child: Text("No Worker Found").tr()));
                }
              } else if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  child: new Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
                );
              }
            },
          ),


        ],
      ),
    );
  }

  Future<List<PeerUser>> userData() async {
    List<PeerUser> list = [];

    await FirebaseFirestore.instance.collection('userProfile').where('usertype',isEqualTo:'guard').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        if (doc.id != FirebaseAuth.instance.currentUser!.uid)
        {
          PeerUser model = PeerUser(
            doc.id.toString(),
            doc.get('name'),
            doc.get('profileLink'),
          );
          list.add(model);
        }

      });
    });

    return list;
  }

}
