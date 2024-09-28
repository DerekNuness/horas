import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:horas/screens/delete_acount_modal.dart';
import 'package:horas/services/auth_service.dart';

class Menu extends StatelessWidget {
  final User user;
  const Menu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 48,
              ),
              //backgroundImage: NetworkImage(user.photoURL!),
            ),
            accountName: Text((user.displayName != null) ? user.displayName! : ''),
            accountEmail: Text(user.email!),
          ),
          ListTile(
            leading: Icon(
              Icons.logout
            ),
            title: const Text('Sair'),
            onTap: () {
              AuthService().deslogar();
            },
          ),
          ListTile(
            leading: Icon(
                Icons.delete
            ),
            title: const Text('Excluir Conta'),
            onTap: () {
              showDialog(context: context, builder: (BuildContext context) {
                return DeleteAcountModal();
              });
            },
          ),
        ],
      ),
    );
  }
}
