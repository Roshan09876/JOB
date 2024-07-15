import 'package:flutter/material.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  TextEditingController msgInputController = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io(
        'http://localhost:5500',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            // .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    setupSocketListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
            backgroundColor: Color(kDark.value), title: Text('Chat List')),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return MessageItem(
                            sentByme: false,
                          );
                        }),
                  )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                color: Color(kOrange.value),
                child: TextField(
                  controller: msgInputController,
                  cursorColor: Color(kDarkPurple.value),
                  style: TextStyle(color: Color(kLight.value)),
                  decoration: InputDecoration(
                      suffixIcon: Container(
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: IconButton(
                            onPressed: () {
                              sendMessage(msgInputController.text);
                              msgInputController.text = '';
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(kLight.value)),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(kLight.value)),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ))
            ],
          ),
        ));
  }

  void sendMessage(String text) {
    var messageJSON = {"message": text, "sentByme": socket.id};
    socket.emit('message', messageJSON);
  }
void setupSocketListener() {
  socket.on('message - recieved', (data){
    print(data);
  });
}
}


class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.sentByme}) : super(key: key);

  final bool sentByme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByme ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: sentByme ? Color(kDarkPurple.value) : Color(kLight.value),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Hello',
                style: TextStyle(
                    fontSize: 20,
                    color: sentByme
                        ? Color(kLight.value)
                        : Color(kDarkPurple.value)),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '10:10 AM',
                style: TextStyle(
                    fontSize: 10,
                    color: sentByme
                        ? Color(kLight.value)
                        : Color(kDarkPurple.value)),
              ),
            ],
          )),
    );
  }
}
