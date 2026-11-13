import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = '/chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  String _messageText = '';

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('Current user: ${user.email}');
        print('Current user: ${loggedInUser?.email}');
      }
      updateState();
    } catch (e) {
      print(e);
    }
  }

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilderWidget(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onChanged: (value) {
                        _messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      _messageController.clear();
                      final result = await _firestore
                          .collection("messages")
                          .add({
                            "text": _messageText,
                            "sender": loggedInUser?.email ?? 'Unknown',
                          });
                    },
                    child: Text('Send', style: kSendButtonTextStyle),
                  ),
                ],
              ),
            ),
            // Text(
            //   'Logged in as: ${loggedInUser?.email ?? 'Unknown'}${loggedInUser?.uid ?? ''}',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 16, color: Colors.white),
            // ),
          ],
        ),
      ),
    );
  }
}

class StreamBuilderWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messagesBubbles = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final messages = snapshot.data!.docs;
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message.data()['sender'];
            final currentUser = loggedInUser?.email;
            var messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messagesBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messagesBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  const new({
    super.key,
    required this.sender,
    required this.text,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.0, left: 6, right: 6, bottom: 2),
            child: Text(
              sender,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topRight: isMe ? Radius.circular(0) : Radius.circular(30),
            ),
            color: isMe ? Colors.white54 : Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.only(bottom: 4, left: 10, right: 10, top: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
