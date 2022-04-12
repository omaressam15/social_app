
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:social_app/screen/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/screen/HomeLayout/cubit/home_state.dart';
import '../styles/icon_broken.dart';
import 'HomeLayout/cubit/home_state.dart';
import 'HomeLayout/cubit/home_state.dart';

class DisplayPickImage  extends StatelessWidget {
  final dynamic imagePick;
  final String receiverId;
  const DisplayPickImage ({Key key,this.imagePick,this.receiverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('receiver ID $receiverId');

    return BlocConsumer<CubitHome,StatesHome>(
      listener: (BuildContext context ,state){
        if(state is SendChattingImageSuccess){
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context ,state){


        var date = DateFormat.yMMMMd().format(DateTime.now());
        var dateTime = DateFormat.yMEd().add_jm().format(DateTime.now());
        var time =DateFormat.jm().format(DateTime.now());
        var chatMassaging = CubitHome.get(context);
        var sendChatController = TextEditingController();


        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imagePick),
                          )
                      ),
                    ),

                    if(state is LoadingSendMessagePhoto)
                     /* Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: LiquidCircularProgressIndicator(
                            value:CubitHome.get(context).progress, // Defaults to 0.5.
                            valueColor: const AlwaysStoppedAnimation(Colors.pink),
                            backgroundColor: Colors.white,
                            borderColor: Colors.red,
                            borderWidth:2.0,
                            direction: Axis.vertical,
                            center:Text('${CubitHome
                                .get(context)
                                .progress} %',style: const TextStyle(fontSize:12.0,fontWeight: FontWeight.w600,color: Colors.black),),
                          ),
                        ),
                      ),*/
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: sendChatController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Can\'t send message empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                            fillColor: const Color(0xfff1f2f6),
                            hintText: 'Write message...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xfff1f2f6)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color(0xfff1f2f6)),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 23,
                      child: IconButton(
                          onPressed: () {

                            chatMassaging.sendMessageChattingWithPhoto(
                              textMassage: sendChatController.text,
                              receiverID: receiverId,
                              dateTime: dateTime,
                              time: time.toString(),
                              date: date.toString(),
                            );
                          },
                          icon: const Icon(
                            IconBroken.Send,
                            size: 26,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
