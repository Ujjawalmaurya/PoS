import 'package:flutter/material.dart';
import 'package:pos/src/constants/constants.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool closeApponLogout = readData("closeAppOnLogout") ?? false;
  bool isMaterial3 = readData('isMaterial3') ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account settings"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            isThreeLine: true,
            title: const Text("Close app after logout"),
            subtitle:
                const Text("This toggle will enable closing app on logout (Android only) [EXPERIMENTAL]"),
            value: closeApponLogout,
            onChanged: (_val) => setState(() {
              closeApponLogout = _val;
              writeData('closeAppOnLogout', closeApponLogout);
            }),
          ),
          SwitchListTile(
            isThreeLine: true,
            title: const Text("User Material3 Design (needs Restart)"),
            subtitle: const Text("User Material You design pattern.\nWorks on Android 12 and above"),
            value: isMaterial3,
            onChanged: (_val) => setState(() {
              isMaterial3 = _val;
              writeData('isMaterial3', isMaterial3);
            }),
          ),
        ],
      ),
    );
  }
}
