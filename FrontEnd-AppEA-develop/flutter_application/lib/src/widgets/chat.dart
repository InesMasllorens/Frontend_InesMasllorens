import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_application/infrastructure/models/deuda.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../repositories/grupo_repository.dart';
import '../../repositories/grupo_repository_impl.dart';
import 'info_grupo.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  Chat(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String userName = Constants.user.name;
  IO.Socket? socket;

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  String userName = Constants.user.name;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'bienvenidos'.tr,
          style: TextStyle(
            fontSize: 18, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Add font weight if desired
            // You can add more properties like color, letterSpacing, etc.
          ),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            appState.setUserName(userName); // set the user name in app state
            if (appState.userName.isNotEmpty) {
              // connect to socket server
              appState.socket = IO.io('http://localhost:4000');
              appState.socket!.connect()
                ..onConnectError((data) {
                  print('Failed to connect to server: $data');
                })
                ..onConnect((data) {
                  print('Connected to server');
                  // Do something now that you know the connection is established
                });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyChatPage()),
              );
            }
          },
          child: Text('start'.tr),
        ),
      ],
    ),
  ),
    );
  }
}

class ChatMessage {
  final String senderName;
  final String messageContent;
  final String timeSent;

  ChatMessage({required this.senderName, required this.messageContent, required this.timeSent});
}

class MyChatPage extends StatefulWidget {
  @override
  _MyChatPageState createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  
  MyAppState? appState;
  String _currentRoom = '';
  List<ChatMessage> _messages = [];
  Map<String,  String> roomNames = {};
  
  
  IO.Socket? socket;

  TextEditingController roomNameController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  void createRoom(String roomName) {
    if (roomName.isNotEmpty && !roomNames.values.contains(roomName)) {
      socket!.emit('CREATE_ROOM', {"roomName": roomName});
      setState(() {
        roomNameController.clear(); // clear the input field
        _currentRoom = roomName;
        socket!.emit("JOIN_ROOM", getKeyFromValue(roomNames, _currentRoom));
        _messages = [];
      });
    }
  }

  void _handleSubmitted(ChatMessage chatMessage) {
    if (_currentRoom.isNotEmpty) {
      socket!.emit("SEND_ROOM_MESSAGE", {"roomId": getKeyFromValue(roomNames, _currentRoom), "message": chatMessage.messageContent, "username": chatMessage.senderName});
      setState(() {
        _messages.insert(0, chatMessage);
        _textController.clear();
      });
    }
  }

  String? getKeyFromValue(Map<String, String> map, String targetValue) {
    for (var entry in map.entries) {
      if (entry.value == targetValue) {
        return entry.key;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    appState = context.read<MyAppState>();
    socket = appState!.socket;

    socket!.on("ROOMS", (rooms) {
      setState(() {
        roomNames.clear();
        final roomsJsonString = jsonEncode(rooms);
        final roomsJson = jsonDecode(roomsJsonString);
        roomsJson.forEach((roomId, roomData) {
          roomNames[roomId] = roomData["name"];
        });
      });
    });

    socket!.on("ROOM_MESSAGE", (data) {
      final roomMessageJsonString = jsonEncode(data);
      final roomMessageJson = jsonDecode(roomMessageJsonString);
      ChatMessage chatMessage = ChatMessage(
        senderName: roomMessageJson['username'],
        messageContent: roomMessageJson['message'],
        timeSent: roomMessageJson['time'],
      );
      setState(() {
        _messages.insert(0, chatMessage);
        _textController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Color.fromARGB(255, 198, 238, 219),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            createRoom(Constants.grupoPopulate.name);
                          },
                          child: Text('entrar_chat'.tr),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: roomNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if(_currentRoom != roomNames.values.elementAt(index)){
                                _currentRoom = roomNames.values.elementAt(index);
                                socket!.emit("JOIN_ROOM", getKeyFromValue(roomNames, _currentRoom));
                                _messages = [];
                              }
                            });
                          },
                          child: Text(roomNames.values.elementAt(index)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              color: Color.fromARGB(255, 216, 243, 247),
              child: Column(
                children: [
                  // Chat room header
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '$_currentRoom',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  // Messages list
                  Expanded(
                    child: ListView.builder(
                      reverse: false,
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        ChatMessage message = _messages[index];
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.senderName,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                message.messageContent,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                message.timeSent,
                                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Message input field and send button
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'mensaje'.tr,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              _handleSubmitted(
                                ChatMessage(
                                  senderName: appState!.userName,
                                  messageContent: _textController.text,
                                  timeSent: DateTime.now().toString(),
                                )
                              );
                            }
                          },
                          child: Text('send'.tr),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}