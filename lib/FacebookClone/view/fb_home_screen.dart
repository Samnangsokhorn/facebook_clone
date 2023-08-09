import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/FacebookClone/model/like_model.dart';
import 'package:firebase_learning/FacebookClone/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookHomepage extends StatefulWidget {
  const FacebookHomepage({super.key});

  @override
  State<FacebookHomepage> createState() => _FacebookHomepageState();
}

class _FacebookHomepageState extends State<FacebookHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStory,
            const SizedBox(
              height: 5,
            ),
            _buildDivider,
            Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                  border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.2)),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '   Justin Bieber and Selena Gomez commented.',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 15,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close,
                              size: 15,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection("post").snapshots(),
              builder: (context, snapshot) {
                List<PostModel> post = snapshot.data!.docs
                    .map((e) => PostModel.fromSnapshot(e))
                    .toList();
                return Column(
                  children: List.generate(snapshot.data!.docs.length,
                      (index) => _buildAllPost(post[index])),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavi(),
    );
  }

  get _buildDivider {
    return Container(
      width: double.infinity,
      height: 7,
      color: Colors.black.withOpacity(0.2),
    );
  }

  _buildAllPost(PostModel post) {
    return Container(
      width: double.infinity,
      height: 500,
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.blue),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.user!['image']))),
                  ),
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(top: 8, left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.user!['name'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post.date}   ',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3)),
                            ),
                            Icon(
                              Icons.language,
                              size: 15,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Text('   ${post.text}'),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: PageView.builder(
              itemCount: post.image!.length,
              itemBuilder: (context, index) {
                return Image.network(post.image![index]);
              },
            ),
          ),
          _buildLikeCommentShare(post),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                horizontal:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.4)),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (post.like!.isLiked == false) {
                              FirebaseFirestore.instance
                                  .collection("post")
                                  .doc(post.id)
                                  .update(
                                    PostModel(
                                          id: post.id,
                                          date: post.date,
                                          comment: post.comment,
                                          image: post.image,
                                          like: LikeModel(
                                              isLiked: true,
                                              like: post.like!.like!+1),
                                          share: post.share,
                                          text: post.text,
                                          user: post.user)
                                      .toMap());
                            } else {
                              FirebaseFirestore.instance
                                  .collection("post")
                                  .doc(post.id)
                                  .update(
                                    PostModel(
                                          id: post.id,
                                          date: post.date,
                                          comment: post.comment,
                                          image: post.image,
                                          like: LikeModel(
                                              isLiked: false,
                                              like: post.like!.like!-1),
                                          share: post.share,
                                          text: post.text,
                                          user: post.user)
                                      .toMap());
                           }
                          },
                          icon: Icon(
                            post.like!.isLiked == false
                                ? FontAwesomeIcons.thumbsUp
                                : Icons.thumb_up,
                            color: post.like!.isLiked == false
                                ? Colors.black.withOpacity(0.4)
                                : Colors.blue,
                          ),
                        ),
                        Text(
                          'like',
                          style: TextStyle(
                            color: post.like!.isLiked == false
                                ? Colors.black.withOpacity(0.7)
                                : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.comment,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Text('Comment',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 40,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.share,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Text('share',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 7,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  _buildLikeCommentShare(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned(
                left: 52,
                bottom: 0,
                child: Text(
                  '${post.like!.like}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Positioned(
                left: 30,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10,
                    child: Icon(
                      Icons.emoji_emotions,
                      color: Colors.orange,
                      size: 20,
                    )),
              ),
              const Positioned(
                left: 16,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    )),
              ),
              const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                    size: 20,
                  )),
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${post.comment} comments'),
              Text('${post.share} shares'),
            ],
          ))
        ],
      ),
    );
  }

  get _buildStory {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 55,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              width: 200,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/horn1.jpg'),
                  ),
                  Text('What\'s on your mind?'),
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.image,
                  color: Colors.green.withOpacity(0.7),
                  size: 30,
                ))
          ]),
        ),
        Container(
          width: double.infinity,
          height: 7,
          color: Colors.black.withOpacity(0.2),
        ),
        SizedBox(
          width: double.infinity,
          height: 190,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 170,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      margin: const EdgeInsets.only(left: 5, top: 10),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/horn1.jpg'))),
                    ),
                    Positioned(
                      top: 100,
                      left: 40,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: const Icon(Icons.add, color: Colors.white)),
                    ),
                    const Positioned(
                      top: 143,
                      left: 10,
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: Column(
                          children: [Text('Create'), Text('story')],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Container(
                      width: 110,
                      height: 180,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 3, color: Colors.blue),
                                // image: DecorationImage(
                                //     fit: BoxFit.cover,
                                //     image: AssetImage(listImage[index])
                                // )
                              ),
                            ),
                            const Text('Horn')
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  get _buildAppbar {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'facebook',
        style: TextStyle(
            color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      actions: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Stack(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Colors.black,
                    )),
              ),
              Positioned(
                left: 27,
                bottom: 32,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: const Center(child: Text(' 1 ')),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  int selectedIndex = 0;
  BottomNavigationBar _buildBottomNavi() {
    return BottomNavigationBar(
        fixedColor: Colors.blue,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_display),
            label: 'Watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ]);
  }
}
