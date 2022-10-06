// packages from - pub.dev

# StatelessWidget

```dart
class Pantho extends StatelessWidget {
  const Pantho({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

# StateFulWidget

```dart
class pantho extends StatefulWidget {
  const pantho({Key? key}) : super(key: key);

  @override
  State<pantho> createState() => _panthoState();
}

class _panthoState extends State<pantho> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

```

# main.dart

```dart

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    initialRoute:'/',
    routes: {
        '/':(context)=> SafeArea(child: Loading()),
      '/home':(context)=>SafeArea(child: Home()),
      '/location':(context)=>SafeArea(child: ChooseLocation()),
    },
));


// switching locations
dynamic result await =Navigator.pushNamed(context, "/home");
Navigator.pushReplacementNamed(context, "/home", argument :{

});


// receive the arguments in home class
Map data=ModalRoute.of(context)?.settings.arguments as Map ;
Navigator.pop(context,{

});


```

# Scaffold

```dart
Scaffold(
    appBar: AppBar(
        backgroundColor:,
        title: ,
        centerTitle: true,
        elevation: ,    // box shadow
    ),
    drawer: Drawer(
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
            const DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                    ),
                    child: Text('Drawer Header'),
                ),
            ListTile(),
            ListTile(),
            ],
        ) ,
    ),
    backgroundColor: ,
    body: ,
    floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ,
        child:,

      ),
)

```

# Add Externals

## fonts

```dart
// pubspec.yaml
fonts:
    - family : name
      fonts:
        - asset: fonderDirectory/file.ttf

```

## Assets

```dart
// pubspec.yaml
assets:
    - directory/
```

# Widgets

### Container

```dart
Container(
    padding:EdgeInsets.fromLTRB( , , , ),
    margin:EdgeInsets.fromLTRB( , , , ),
    color: ,
    child: ,
)
```

### Padding

```dart
Padding(
    padding:EdgeInsets.fromLTRB( , , , ),
    child: ,
)
```

### Row

```dart
Row(
    mainAxisAlignment: MainAxisAlignment.center
    crossAxisAlignment:CrossAxisAlignment.center
    children:[
        Widget,
        Widget,
        Expanded(
            flex: , // divisionInFlexBox
            child: ,
        ),
    ],
)
```

### Column

```dart
Column(
    mainAxisAlignment: MainAxisAlignment.center
    crossAxisAlignment:CrossAxisAlignment.center
    children:[
        Widget,
        Widget
    ],
            :quotes.map( q=> Text(q) ).toList(),
)
```

### center

```dart
Center(
    child: ,
)
```

### Text

```dart
Text(
    "text that will display",
    style:TextStyle(
        fontSize: ,
        fontWeight:FontWeight.___ ,
        letterSpacing: ,
        color: Colors.___ ,
        fontFamily: "___",
    ),
)

```

### Button

```dart
TextButton(
    onPressed:(){},
    child: ,
    color: ,
)

ElevatedButton(
    onPressed:(){},
    child: ,
    color: ,
)

ElevatedButton.icon(
    onPressed:(){},
    label:Text(""),
    icon:Icons(Icons.___),
    color:Colors.___,
)
IconButton(
    onPressed:(){},
    icon:Icons(Icons.___),
    color:Colors.___,
)

```

### image

```dart
Image(
    image:NetworkImage("url"),
         :AssetImage("direction"),
    fit:BoxFit.___ ,
)
Image.network("url"),
Image.asset("direction")
```

### Circle Avatar

```dart
CircleAvatar(
    backgroundImage:AssetImage("direction"),
    radius: 40,
)

```

### icon

```dart
Icon(
    Icons.___,
    color : ,
    size: 30,
)
```

### Sized box

```dart
SizedBox(
    height: 10,
    width: 10,
),
```

### Divider

```dart
Divider(
    height: ,
    color: ,
)
```

### Card

```dart
Card(
    margin: ,
    padding: ,
    child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch
        children:[
            Widget,
            Widget
        ],
    ),

)

```

### List view builder

```dart
ListView.builder(
    itemCount: list.length,
    itemBuilder:(context, index){
        return Card(
            child: ListTile(
                onTap:(){},
                title: ,
                leading:CircleAvatar() ,
            ),
        );
    }
)
```
