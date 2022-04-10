import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Providers/User.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var isLoading = false;
  var searchController = TextEditingController();
  var amb = false;
  @override
  Widget build(BuildContext context) {
    amb = false;
    final Media = MediaQuery.of(context);
    final user = Provider.of<User>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: const Text(
          "Edit/Remove Users",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Center(
          child: Text(
            "QIU",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: const IconButton(
              onPressed: null,
              icon: Icon(
                FontAwesomeIcons.graduationCap,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Media.size.height,
        width: Media.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Media.size.height * .05,
              ),
              SizedBox(
                // color: Colors.amber,
                height: Media.size.height * .1,
                width: Media.size.width * .85,
                child: TextField(
                  onChanged: (value) async {
                    setState(() {
                      isLoading = true;
                    });
                    await user.searchUsers(value).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                    });

                    print(user.suggestions);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await user
                            .searchUsers(searchController.text)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        size: 32,
                        color: Color.fromARGB(255, 111, 112, 153),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(124, 131, 253, 1), width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 111, 112, 153),
                          width: 2.0),
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
              Center(
                child: isLoading
                      ? const CircularProgressIndicator() : SizedBox(
                  height: Media.size.height * .8,
                  width: Media.size.width * 85,
                  child: ListView.builder(
                    itemCount: user.suggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(user.suggestions[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
