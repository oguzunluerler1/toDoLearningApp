import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<String> TaskList = [];
  List<String> CompletedList = [];
  TextEditingController tf = TextEditingController();
  bool isFirstTime = true;
  late SharedPreferences pref;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future initSharedPref () async {
    pref = await SharedPreferences.getInstance();
    TaskList = await pref.getStringList("incompleteLy") ?? [];
    CompletedList = await pref.getStringList("completeLy") ?? [];
    setState(() {
      
    });
  print(TaskList);
  print(CompletedList);
  }

  void SaveTask() async {
    await pref.setStringList("incompleteLy", TaskList);
    await pref.setStringList("completeLy", CompletedList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text("Errand Generator",style: TextStyle(color: Color.fromARGB(255, 34, 22, 68)),),
      ),
      floatingActionButton: FAButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: bodyMethod()
    );
  }

  FloatingActionButton FAButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
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
              isFirstTime = false;
              SaveTask();
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
          ? isFirstTime==true ? Text("Write the tasks here via the add button down below.",textAlign: TextAlign.center,) :Image.network("https://i.ytimg.com/vi/rDleFy3yFB8/hqdefault.jpg") 
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
                      SaveTask();
                      setState(() {
                        
                      });
                    }, icon: Icon(Icons.delete, color: Colors.red.shade400,)
                  ),
                  value: false,
                  onChanged: (isChecked){
                    CompletedList.add(TaskList[index]);
                    TaskList.removeAt(index);
                    SaveTask();
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
                      SaveTask();
                      setState(() {
                        
                      });
                      
                    }, icon: Icon(Icons.delete, color: Colors.red.shade400,)
                  ),
                  value: true,
                  onChanged: (isChecked){
                    TaskList.add(CompletedList[index]);
                    CompletedList.removeAt(index);
                    SaveTask();
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