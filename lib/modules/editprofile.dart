import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/shared/component.dart';

import 'package:social_media/shared/style/colors/colors.dart';

class EditPrpfile_screen extends StatefulWidget {
  const EditPrpfile_screen({Key? key}) : super(key: key);

  @override
  _EditPrpfile_screenState createState() => _EditPrpfile_screenState();
}

class _EditPrpfile_screenState extends State<EditPrpfile_screen> {
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var biocontroller = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, socialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = SocialCubit.get(context).usermodel;
            var imageProfile = SocialCubit.get(context).profileImage;
            var imageCover = SocialCubit.get(context).coverImage;

            namecontroller.text = model!.name!;
            phonecontroller.text = model.phone!;
            biocontroller.text = model.bio!;
            return Scaffold(
              appBar: AppBar(
                title: Text('Edit Profile'),
                actions: [
                  TextButton(
                      onPressed: () {
                        SocialCubit.get(context).updateUser(
                            name: namecontroller.text,
                            bio: biocontroller.text,
                            phone: phonecontroller.text);
                        // SocialCubit.get(context).updateUsertest();
                      },
                      child: Text(
                        'DONE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      if (state is LoadingUpdateUserState)
                        LinearProgressIndicator(),
                      if (state is LoadingUpdateUserState)
                        SizedBox(
                          height: 5,
                        ),
                      Container(
                        width: double.infinity,
                        height: 180,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                width: double.infinity,
                                height: 140,
                                child: Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      BuildCondition(
                                        condition: imageCover == null,
                                        builder: (context) => Image(
                                          image:
                                              NetworkImage(model.coverimage!),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        fallback: (context) => Image(
                                          image: FileImage(imageCover!),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 19,
                                        child: IconButton(
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .getcoverImage();
                                          },
                                          icon: Icon(
                                              Icons.camera_enhance_outlined),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: BuildCondition(
                                    condition: imageProfile == null,
                                    builder: (context) => CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      radius: 55,
                                      backgroundImage:
                                          NetworkImage(model.image!),
                                    ),
                                    fallback: (context) => CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      backgroundImage: FileImage(
                                        imageProfile!,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 19,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getprofileImage();
                                    },
                                    icon: Icon(Icons.camera_enhance_outlined),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      //if(state is SuccessGetImageprofileState ||state is SuccessGetImageCoverState)

                      Row(
                        children: [
                          if (imageProfile != null)
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 53,
                                    width: double.infinity,
                                    child: MaterialButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadProfileImage();
                                      },
                                      color: defultcolor,
                                      child: Text(
                                        'Edit Profile Image',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (state is LoadingUpdateprofileUserState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (imageCover != null)
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 52,
                                    child: MaterialButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadCoverImage();
                                      },
                                      color: defultcolor,
                                      child: Text(
                                        'Edit Cover Image',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (state is LoadingUpdatecoverUserState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defultTextField(
                        context: context,
                        vaildate: (value) {},
                        controller: namecontroller,
                        prefix: Icons.supervised_user_circle,
                        labal: 'name',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defultTextField(
                        context: context,
                        vaildate: (value) {},
                        controller: biocontroller,
                        prefix: Icons.info_outline,
                        labal: 'bio',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defultTextField(
                        context: context,
                        vaildate: (value) {},
                        controller: phonecontroller,
                        prefix: Icons.phone,
                        labal: 'phone',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
             ),
            );
          }
    );
  }
}
