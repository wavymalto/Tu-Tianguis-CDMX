import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataformav1/config/theme/theme_provider.dart';

//Clase con el boton de Settings que hace el cambio de color

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pantalla de configuracion con un boton de dark mode/light mode'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Consumer<ThemeProvider>(
                      builder: (context, provider, child) {
                        return DropdownButton<String>(
                          value: provider.currentTheme,
                          items: [
                            DropdownMenuItem<String>(
                              value: 'light',
                              child: Text(
                                'Light',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'dark',
                              child: Text(
                                'Dark',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'system',
                              child: Text(
                                'System',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                          onChanged: (String? value) {
                            provider.changeTheme(value ?? 'system');
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
