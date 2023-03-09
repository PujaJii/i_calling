import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/search_page.dart';


class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  final List colors = [
    const Color(0x3300AF5B),
    const Color(0x331800AF),
    const Color(0x33AF4A00),
    const Color(0x33AF0000),
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
         const Center(
           child: CircularProgressIndicator(color: Colors.green,),)
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
                   return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: colors[index % colors.length],),
                      child: contacts[index].givenName == null || contacts[index].givenName == ''?
                      const Center(child:  Text('U',style: TextStyle(color: Colors.white,fontSize: 20))):
                      Center(child: Text(((contacts[index].givenName!).substring(0,1)),style: const TextStyle(color: Colors.white,fontSize: 20))),
                    ),
                    title:
                    contacts[index].givenName == null || contacts[index].givenName == ''?
                    const Text('Unknown'):
                    Text(contacts[index].givenName!,style: const TextStyle(fontSize: 14)),
                    subtitle:contacts[index].phones ==null || contacts[index].phones!.isEmpty?
                    const Text(''):
                    Text(contacts[index].phones!.first.value.toString()),
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