import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/EditProfile/edit_profile_screen.dart';
import 'package:social_app/styles/icon_broken.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType textInputType,
  @required Function validator,
  @required String label,
  @required IconData iconData,
  bool isPassword = false,
  Function onTap,
  IconData suffix,
  Function isPressed,
  Function onChange,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: (String value) {
      },
      onChanged: onChange,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(iconData),

        suffixIcon: suffix != null
            ? InkWell(onTap: isPressed, child: Icon(suffix)) : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget appBar({String title, List<Widget> action,context}){

  return AppBar(
    title: Text(title),
    actions: action,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
        icon: const Icon(IconBroken.Arrow___Left_2,),
      color: Colors.black,
    ),
  );

}



/*
Widget buildListViewProductItem (product,context,{isOldPrice = true,bool fav = true})=>InkWell(
  onTap: ()=>navigate(ProductDetails(ID: product.id,), context),
  child: Padding(

    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(image: NetworkImage(product.image),height: 120,width: 120,),
              if(product.discount !=0 && isOldPrice)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 9.0),),

                ),

            ],
            alignment: Alignment.bottomLeft,
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 3,),

                Text(product.name,maxLines: 2,style: const TextStyle(color: Colors.black,fontSize: 14),),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${product.price}',style: const TextStyle(color: Colors.blue),),

                    const SizedBox(width: 10,),
                    if(product.discount !=0 && isOldPrice)
                      Text('${product.oldPrice}',style: const TextStyle(fontSize: 11,color: Colors.grey,decoration: TextDecoration.lineThrough),),

                    const Spacer(),

                    if(fav)
                    IconButton(

                        onPressed: (){
                          HomeCubit.get(context).postFavorites(product.id);
                        },
                        iconSize: 20,
                        icon: Icon(HomeCubit.get(context).favorites[product.id]?Icons.favorite:Icons.favorite_border,

                          color:HomeCubit.get(context).favorites[product.id]?Colors.red:Colors.grey.withOpacity(0.5) ,
                        )),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
*/

/*
 Widget buildTaskItem(Map model,context,)=> Dismissible(
   
   key: Key(model['id'].toString()),

   onDismissed: (direction){

     AppCubit.get(context).deleteDatabase(id: model['id'],);

   },

   child: Padding(
      padding: EdgeInsets.all(15),
      child: Row(

        children: [

          CircleAvatar(
            radius: 35,
            child: Text(model['time']),

          ),

          SizedBox(
            width: 15,
          ),

          Expanded(
            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text('${model['title']}',style: TextStyle(fontSize: 20,color: Colors.black,
                    fontWeight: FontWeight.bold),),
                Text('${model['date']}',style: TextStyle(color: Colors.grey),),

              ],

            ),
          ),
          IconButton(

            key: Key(model['id'].toString()),


            onPressed: (){
            
            if(AppCubit.get(context).select){
              AppCubit.get(context).changeIcon(iconData: Icons.check_box_outline_blank,selected: false);
              AppCubit.get(context).updateDatabase(states:'new', id: model['id']);


            }else {
              AppCubit.get(context).updateDatabase(states:'done', id: model['id']);
              AppCubit.get(context).changeIcon(iconData: Icons.check_box,selected: true);
            }
            
          }, icon: Icon(AppCubit.get(context).icon),

           

          ),

          */

/*Checkbox(

              value:AppCubit.get(context).checkBox ,
              onChanged: (value){

               AppCubit.get(context).checkBox =value;
                AppCubit.get(context).updateDatabase(states:'done', id: model['id']);
          }),*/

/*


          SizedBox(
            width: 20,
          ),
          IconButton(onPressed: (){

            AppCubit.get(context).updateDatabase(states:'achieved', id: model['id']);

          },

              icon: Icon(Icons.archive),

            color: Colors.grey,

          ),

        ],

      ),
    ),
 );
*/

/*
 Widget conditionalItem({@required List<Map>tasks })=> ConditionalBuilder(
   builder:(context)=> ListView.separated(
       itemBuilder: (context, index) =>
           buildTaskItem(tasks[index], context),
       separatorBuilder: (context, index) => myDivider(),

       itemCount: tasks.length,),
   condition:tasks.length >0 ,
   fallback:(context)=>Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Icon(Icons.event_note_outlined,color: Colors.grey,size: 90,),
         SizedBox(
           height: 15,
         ),
         Text('Task is Empty!',style: TextStyle(color: Colors.grey,fontSize: 23,fontWeight: FontWeight.bold),)
       ],
     ),
   ),



 );
*/

/*
 Widget buildArticleItem (article,context) =>InkWell(
   onTap: (){
     navigate(WepViewScreen(article['url']), context);

   },
   child: Padding(
     padding: const EdgeInsets.all(20),
     child: Row(

       children: [

         Container(

           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
             image: DecorationImage(
                 image: NetworkImage('${article['urlToImage']}'),

                 fit: BoxFit.cover

             ),
           ),

           width: 120,
           height: 120,

         ),

         const SizedBox(width: 10,),

         Expanded(
           child: SizedBox(
             height: 120,
             child: Column(

               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,

               children: [

                 Expanded(
                   child: Text('${article['title']}',

                     style: Theme.of(context).textTheme.bodyText1,
                     maxLines: 3,
                     overflow: TextOverflow.ellipsis,

                   ),
                 ),

                 Text('${article['publishedAt']}',style: Theme.of(context).textTheme.bodyText2,),

               ],

             ),
           ),
         ),


       ],

     ),
   ),
 );
*/

 Widget myDivider()=>Padding(
   padding: const EdgeInsets.symmetric(horizontal:15 ),
   child: Container(
     width: double.infinity,
     color: Colors.grey,
     height: 0.5,
   ),
 );

/*
 Widget articalBulider(list)=> ConditionalBuilder(
   builder: (BuildContext context) =>ListView.separated(
       physics: const BouncingScrollPhysics(),

       itemBuilder: (context,index)=>buildArticleItem(list[index],context),
       separatorBuilder:(context,index)=> myDivider(),
       itemCount: list.length),

   condition:list.length>0,

   fallback:(context)=> const Center(child: CircularProgressIndicator(),),

 );
*/
 void showToast ({String text,ToastStates state}){

   Fluttertoast.showToast(
       msg:text,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 5,
       backgroundColor: chooseToastColor(state),
       textColor: Colors.white,
       fontSize: 16.0
   );
 }

 enum ToastStates {SUCCESS,ERROR,WARNING}

 Color chooseToastColor (ToastStates states){

   Color color;

   switch(states){

     case ToastStates.SUCCESS:
       color = Colors.green;
       break;

     case ToastStates.ERROR:
       color = Colors.red;
       break;

     case ToastStates.WARNING:
       color = Colors.amber;
       break;
   }

   return color;

 }



 void navigate(Widget page,context)=> Navigator.push(
   context,
   MaterialPageRoute(
     builder: (context) =>page,
   ),
 );
 void navigateNoBack(Widget page,context)=> Navigator.pushReplacement(
   context,
   MaterialPageRoute(
     builder: (context) =>page,
   ),
 );
