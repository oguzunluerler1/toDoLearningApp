import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<String> TaskList = [
    "Take out emre", "Do the dishes", "Do the laundry", "Go to the grocery store", "Pay the bills"
  ];
  List<String> CompletedList = [];

  TextEditingController tf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text("a"),
      ),
      floatingActionButton: FAButton(),
      body: bodyMethod()
    );
  }

  FloatingActionButton FAButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        tf.clear();
        openDialog();
      }
    );
  }

  void openDialog() {
    showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tf,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  
                )
              ),
            ),
            ElevatedButton(onPressed: (){
              TaskList.add(tf.text);
              setState(() {
                
              });
              Navigator.pop(context);
            }, child: Text("Add task"))
          ],
        ),
      ),
    );
  }



  Widget bodyMethod() {
    return Container(
      decoration: gradBackgroundColor(),
      child: ListView(
        children: [
          SizedBox(height: 8),
          Center(child: Text("Stuff to do;", style: TextStyle(fontSize: 30),)),
          dividerBetween(),  
          TaskList.length == 0 
          ? Image.network("https://i.ytimg.com/vi/rDleFy3yFB8/hqdefault.jpg") 
          : ListView.builder(
              shrinkWrap: true,
              itemCount: TaskList.length,
              itemBuilder: (BuildContext context, int index) {
                return toDoCards(index);
              },  
            ),
      
          CompletedTaskAndIcon(),
        ],
      ),
    );
  }

  Widget expansionTileCompletedAssets() {
    return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), 
            itemCount: CompletedList.length,
            itemBuilder: (BuildContext context, int index) {
              return completedToDoCards(index);
            },
          );
  }

  Column CompletedTaskAndIcon() {
    return Column(
      children: [
        dividerBetween(),
        ExpansionTile(
          children: [
            expansionTileCompletedAssets(),
          ],
          iconColor: Color.fromARGB(255, 4, 56, 146),
          title: Text("Completed tasks below!",style: TextStyle(fontWeight: FontWeight.bold),),
          textColor: Color.fromARGB(255, 4, 56, 146),
          leading: Icon(Icons.thumb_up_outlined),
        ),
        SizedBox(width: 10,),
        
            dividerBetween(),
      ],
    );
  }

  Card toDoCards(int index) {
    return Card(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("${TaskList[index]}"),
                  secondary: IconButton(
                    onPressed: (){
                      TaskList.removeAt(index);
                      setState(() {
                        
                      });
                    }, icon: Icon(Icons.delete, color: Colors.red.shade400,)
                  ),
                  value: false,
                  onChanged: (isChecked){
                    CompletedList.add(TaskList[index]);
                    TaskList.removeAt(index);
                    setState(() {
                      
                    });
                  }
                ),
              );
  }  
  Card completedToDoCards(int index) {
    return Card(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("${CompletedList[index]}"),
                  secondary: IconButton(
                    onPressed: (){
                      CompletedList.removeAt(index);
                      setState(() {
                        
                      });
                      
                    }, icon: Icon(Icons.delete, color: Colors.red.shade400,)
                  ),
                  value: true,
                  onChanged: (isChecked){
                    TaskList.add(CompletedList[index]);
                    CompletedList.removeAt(index);
                    setState(() {
                      
                    });
                  }
                ),
              );
  }

  Divider dividerBetween() {
    return Divider(
          color: Colors.red, 
          thickness: 2,
          endIndent: 15,
          indent: 15,
        );
  }

  BoxDecoration gradBackgroundColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lime.shade300,
          Colors.green.shade300,
          Colors.red.shade200
        ]
      )
    );
  }
}