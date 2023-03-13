import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/search_page.dart';
import 'package:i_calling/pages/user_profile.dart';

import '../styles/app_colors.dart';


class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  final List colors = [
    AppColors.pattern1,
    AppColors.pattern2,
    AppColors.pattern3,
    AppColors.pattern4,
  ];
  List<Color> colors2 = [
    // const Color(0x3300AF5B),

    Color(0xFF00AF5B),
    Color(0xFF1800AF),
    Color(0xFFAF4A00),
    Color(0xFF13828A),
  ];


  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContacts();
   // getContactPermission();
  }


  Future<void> fetchContacts() async {
    contacts = await ContactsService.getContacts();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading ?
         Center(
           child: CircularProgressIndicator(color: AppColors.themeColor,),)
            :
        Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: InkWell(
                onTap: () {
                  Get.to(()=> const SearchPage());
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color:  Color(0x30818181),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 15,),
                      Icon(Icons.search),
                      Text('     Search'),
                    ],
                  ),
                ),
              ),
            ), const SizedBox(height: 20,),
            Text('Total Contacts (${contacts.length.toString()})'),
            Expanded(
              child: ListView.builder(
                   itemCount: contacts.length,
                   itemBuilder: (context, index) {
                   return InkWell(
                     onTap: () {
                       Get.to(()=> UserProfile(
                           contacts[index].givenName.toString(),
                           contacts[index].phones!.first.value.toString(),
                           colors[index % colors.length],colors2[index % colors.length]));
                     },
                     child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),color: colors[index % colors.length],
                        ),
                        child: contacts[index].givenName == null || contacts[index].givenName == ''?
                        Center(child:  Text('U',style: TextStyle(color: colors2[index % colors.length],fontSize: 20))):
                        Center(child: Text(((contacts[index].givenName!).substring(0,1)),
                            style: TextStyle(color: colors2[index % colors.length],fontSize: 20))),
                      ),
                      title:
                      contacts[index].givenName == null || contacts[index].givenName == ''?
                      const Text('Unknown'):
                      Text(contacts[index].givenName!,style: const TextStyle(fontSize: 14)),
                      subtitle:contacts[index].phones ==null || contacts[index].phones!.isEmpty?
                      const Text(''):
                      Text(contacts[index].phones!.first.value.toString()),
                  ),
                   );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}