
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfilePage extends HookWidget {
  final String title;

   const ProfilePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Kullanıcı bilgileri bunlar datadan gelecek
    final name = useState('Ramazan Gncer');
    final email = useState('gncrgs@gmail.com');
    final profileImageUrl = useState('https://instagram.fist6-3.fna.fbcdn.net/v/t51.2885-19/67740120_410485642943227_2390037291771887616_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fist6-3.fna.fbcdn.net&_nc_cat=107&_nc_ohc=CTKtm3s4YAwQ7kNvgHf4BZJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYDXvQj5odwq3lVXTN0zAUvY4tVezPw3N11XjhrdWQAIPg&oe=6668E67E&_nc_sid=8b3546');

    return Scaffold(
     appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        
        ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
          
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
            
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(profileImageUrl.value),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Name: ${name.value}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Email: ${email.value}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}