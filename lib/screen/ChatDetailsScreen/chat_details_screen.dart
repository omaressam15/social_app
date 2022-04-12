import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../styles/icon_broken.dart';
import '../HomeLayout/cubit/home_cubit.dart';
import '../HomeLayout/cubit/home_state.dart';
import 'widget/container_of_date.dart';
import 'widget/item_card _chat.dart';

class ChatDetailsScreen extends StatelessWidget {
  final String userImage;

  final String userName;

  final String receiverId;
  final String tokenDevice;



   ChatDetailsScreen(
      {Key key,
      this.tokenDevice,
      this.userImage,
      this.userName,
      this.receiverId})
      : super(key: key);

  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        CubitHome.get(context).getMessageChatting(receiverId: receiverId);

        return BlocConsumer<CubitHome, StatesHome>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {

            var date = DateFormat.yMMMMd().format(DateTime.now());
            var dateTime = DateFormat.yMEd().add_jm().format(DateTime.now());
            var sendChatController = TextEditingController();
            var chatMassaging = CubitHome.get(context);
            var time = DateFormat.jm().format(DateTime.now());


            return Scaffold(
              backgroundColor: const Color(0xffefe6dd),
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        userImage,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [

                  Expanded(
                    child: ConditionalBuilder(
                      condition: chatMassaging.listOfChats.isNotEmpty,
                      fallback: (context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.chat,
                              color: Colors.grey,
                              size: 90,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'No Chat yet with \n$userName',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Column(
                            children: [
                             /* Expanded(
                                child: GroupedListView<dynamic, String>(
                                  elements: CubitHome.get(context).listOfChats.map((e) => ChatData.fromJson(e)).toList(),
                                  groupBy: (element) => element['date'],
                                  groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
                                  itemBuilder: (context, dynamic element) => Text(element['Message']),
                                  itemComparator: (item1, item2) => item1['date'].compareTo(item2['date']), // optional
                                  useStickyGroupSeparators: true, // optional
                                  floatingHeader: true, // optional
                                  order: GroupedListOrder.ASC, // optional
                                ),
                              ),*/

                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    var massages = CubitHome.get(context)
                                        .listOfChats[index];

                                    if (massages.senderId ==
                                        CubitHome.get(context)
                                            .userDataModel
                                            .uId) {
                                      return Column(
                                        children: [
                                          //if (massages.date[index] != date)
                                            //for(int i=1; i<=chatMassaging.listOfChats.length; i++)
                                            ContainerOfDate(
                                              date: massages.date,
                                           ),
                                          itemCardChatRight(massages,context,index),
                                        ],
                                      );
                                    }
                                    return Column(
                                      children: [
                                        //if (massages.date[index] == date)

                                          ContainerOfDate(
                                          date: massages.date,
                                        ),
                                        itemCardChatLeft(massages,context,index),
                                      ],
                                    );
                                  },
                                  primary: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: chatMassaging.listOfChats.length,
                                  shrinkWrap: false,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 0,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                  prefixIcon: const Icon(IconBroken.Chat),
                                  suffixIcon:  InkWell(
                                    onTap: ()=> chatMassaging.pickerChatImage(context: context,receiverId: receiverId),
                                      child: const Icon(Icons.attach_file)),
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
                                  )),
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
                                  if (formKey.currentState.validate()) {
                                    chatMassaging.sendNotification(
                                      body: sendChatController.text,
                                      title:
                                          '${chatMassaging.userDataModel.name} send you massage',
                                      token: tokenDevice,
                                    );

                                    chatMassaging.sendMessageChatting(
                                      textMassage: sendChatController.text,
                                      receiverID: receiverId,
                                      dateTime: dateTime,
                                      time: time.toString(),
                                      date: date.toString(),
                                    );
                                  }
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
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
