import 'package:flutter/material.dart';
import 'package:horas/services/auth_service.dart';

class DeleteAcountModal extends StatefulWidget {
  const DeleteAcountModal({super.key});

  @override
  State<DeleteAcountModal> createState() => _PasswordResetModalState();
}

class _PasswordResetModalState extends State<DeleteAcountModal> {
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Excluir Conta'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _senhaController,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
              labelText: 'Senha'
          ),
          validator: (value) {
            if(value!.isEmpty) {
              return 'Insira sua senha!';
            }
            return null;
          },
        ),
      ),
      actions: <TextButton>[
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        },
            child: Text('Cancelar')
        ),
        TextButton(onPressed: (){
          if(_formKey.currentState!.validate()) {
            authService.excluirConta(senha: _senhaController.text).then((String? erro) {
              Navigator.of(context).pop();

              if(erro != null) {
                final snackBar = SnackBar(
                  content: Text(erro),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                final snackBar = SnackBar(
                  content: Text('Sua conta foi excluida'),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          }
        }, child: Text('Excluir')
        ),
      ],
    );
  }
}
