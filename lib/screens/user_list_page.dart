import 'package:flutter/material.dart';
import 'package:user_diteals/models/user.dart';
import 'package:user_diteals/services/api_service.dart';

class UserListShow extends StatefulWidget {
  const UserListShow({super.key});

  @override
  State<UserListShow> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListShow> {
  late Future<List<User>> _users;
  @override
  void initState() {
    super.initState();
    _users = ApiService.fetchUsers(); //use a Future to manage async API call.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User list')),
     //use Future Builder to handel async UI state.
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
           //Show loading indicator while data is loading.
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            //handel the error
            return _buildError(snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No User Found"));
          }

          //Display each user's: name ,email,company
          final userSh = snapshot.data!;
          return ListView.separated(
              itemCount: userSh.length,
              padding: const EdgeInsets.all(8),
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final user1 = userSh[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(user1.id.toString())),
                  title: Text(user1.name),//display name
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user1.email),//display email
                      Text('Company: ${user1.companyName}'),//display company name.
                    ],
                  ),
                );
              },
              );
        },
      ),
    );
  }
  Widget _buildError(String massage){
    return Center(
      child: Padding(padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_outlined,color: Colors.red,size: 48,),
            const SizedBox(height: 16,),
            Text(massage,
            textAlign: TextAlign.center,style: const TextStyle(fontSize:16),),
            const SizedBox(height: 20,),
            ElevatedButton.icon(onPressed: () {
              setState(() {
                _users=ApiService.fetchUsers();
              });
            }, icon: const Icon(Icons.refresh),
            label: const Text("Retry"),)
          ],
        ),
      ),
    );
  }
}
