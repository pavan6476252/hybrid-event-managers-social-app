import 'package:flutter/material.dart';

import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/background_illustration.dart';
import 'package:hybrid/utils/size_constants.dart';

import '../components/chat_component.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({Key? key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundIllustrations.backGroundIllustration(
            context: context,
            top: MediaQuery.of(context).size.height / 3,
            left: -MediaQuery.of(context).size.width / 1.5,
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColorConstants.transparent,
                  elevation: 0,
                  forceMaterialTransparency: true,
                  snap: true,
                  floating: true,
                  pinned: true,
                  title: const Text(
                    "Messages",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(double.maxFinite, 78),
                    child: _searchBar(),
                  ),
                ),
                _chatsBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: AppColorConstants.gray.withOpacity(0.2),
            // spreadRadius: 1,
            blurRadius: 5,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Icon(
              Icons.search,
              size: AppSizeConstants.bottomNavBarIconSize,
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search for contacts',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatsBuilder() {
    final List<Map<String, dynamic>> chatData = [
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '2m ago',
        'message': 'Hey, how are you doing?',
        'unread': 2,
      },
      {
        'name': 'Other Person',
        'image':
            'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '5m ago',
        'message': 'I am doing great, thanks for asking. How about you?',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '10m ago',
        'message':
            'I am doing well too, thanks. What have you been up to lately?',
        'unread': 1,
      },
      {
        'name': 'Other Person',
        'image':
            'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '15m ago',
        'message': 'Not much, just working on some projects. How about you?',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '20m ago',
        'message':
            'Same here, just trying to stay productive. Have a good day!',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '2m ago',
        'message': 'Hey, how are you doing?',
        'unread': 2,
      },
      {
        'name': 'Other Person',
        'image':
            'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '5m ago',
        'message': 'I am doing great, thanks for asking. How about you?',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '10m ago',
        'message':
            'I am doing well too, thanks. What have you been up to lately?',
        'unread': 1,
      },
      {
        'name': 'Other Person',
        'image':
            'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '15m ago',
        'message': 'Not much, just working on some projects. How about you?',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '20m ago',
        'message':
            'Same here, just trying to stay productive. Have a good day!',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '2m ago',
        'message': 'Hey, how are you doing?',
        'unread': 2,
      },
      {
        'name': 'Other Person',
        'image':
            'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '5m ago',
        'message': 'I am doing great, thanks for asking. How about you?',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '10m ago',
        'message':
            'I am doing well too, thanks. What have you been up to lately?',
        'unread': 1,
      },
      {
        'name': 'Other Person',
        'image':
            'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '15m ago',
        'message': 'Not much, just working on some projects. How about you?',
        'unread': 0,
      },
      {
        'name': 'You',
        'image':
            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'time': '20m ago',
        'message':
            'Same here, just trying to stay productive. Have a good day!',
        'unread': 0,
      },
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          final Map<String, dynamic> chat = chatData[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['image']),
            ),
            title: Text(
              chat['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              chat['message'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                if (chat['unread'] > 0)
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 10,
                    child: Text(
                      chat['unread'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const  ChatComponent()));
            },
          );
        },
        childCount: chatData.length,
      ),
    );
  }
}
