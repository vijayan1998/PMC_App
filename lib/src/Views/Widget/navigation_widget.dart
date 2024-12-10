import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  final String text;
  const NavigationWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
                    width: 70,
                    height: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius:const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: theme.hintColor.withOpacity(0.50)
                    ),
                    child:  Text(text,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black
                    ),
                    textAlign: TextAlign.center,
                    ),
                  );
                  
  }
}