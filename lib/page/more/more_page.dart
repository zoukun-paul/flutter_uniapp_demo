

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SafeArea(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:"appId",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                FilledButton(onPressed: (){}, child: Text("open"))
              ],
            ),
            SizedBox(height: 10,),
            divider(bgColor: Colors.red, horizontal: true),
            SizedBox(height: 10,),
            TextButton(onPressed: () async {
              const channel = MethodChannel('UniMP_mini_apps');
              channel.invokeMethod("open",{'AppID': "__UNI__3BC70CE"});
            }, child: Text("local-uniAPP-1")),
            TextButton(onPressed: () async {
              const channel = MethodChannel('UniMP_mini_apps');
              channel.invokeMethod("open",{'AppID': "__UNI__7AEA00D", "remote":true});
            }, child: Text("remote-uniAPP-1")),
            Expanded(child: Container(color: Colors.transparent,))
          ],
        ),
      ),
    );
  }
}
