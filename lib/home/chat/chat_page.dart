import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, 0),
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Driver',
                    style: TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () => showSearch(
                        context: context, delegate: CustomSearchDelegate()),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: 20,
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildChatBubble(index.isEven ? false : true),
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Row(
                children: [
                  const Icon(
                    Icons.attachment_outlined,
                  ),
                  SizedBox(
                    width: 4.h,
                  ),
                  Flexible(
                      child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(left: 10),
                        suffixIcon: const Icon(Icons.send),
                        constraints:
                            const BoxConstraints(maxHeight: 40, minHeight: 40),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(color: Colors.white))),
                  )),
                  SizedBox(
                    width: 4.h,
                  ),
                  const Icon(Icons.emoji_emotions_outlined)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildChatBubble(bool isMe) {
  return Row(
    mainAxisAlignment:
        isMe == true ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      isMe == false
          ? const CircleAvatar(
              backgroundColor: Color(0xffBCA37F),
            )
          : const SizedBox(),
      isMe == false
          ? Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFFF2D8)),
              child: const Text('How May i help you?'),
            )
          : Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: textcyanColor),
              child: const Text(
                'How May i help you?',
                style: TextStyle(color: Colors.white),
              ),
            )
    ],
  );
}

class CustomSearchDelegate extends SearchDelegate<String> {
  // Dummy list
  final List<String> searchList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // When pressed here the query will be cleared from the search bar.
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchResults = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]),
          onTap: () {
            // Handle the selected search result.
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            // Show the search results based on the selected suggestion.
          },
        );
      },
    );
  }
}
