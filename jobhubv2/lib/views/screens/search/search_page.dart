import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/services/helpers/jobs_helper.dart';
import 'package:jobhubv2_0/views/common/loader.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/job_vertical_tile.dart';
import 'package:jobhubv2_0/views/screens/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          child: CustomField(controller: controller,ontap: (){
               setState(() {
                 
               });
          },),
        ),
      ),

      body: controller.text.isNotEmpty? 
        Padding(padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.w),
        child: FutureBuilder<List<JobsResponse>>(
            future: JobsHelper.SearchJobs(controller.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.data!.isEmpty) {
                return Center(child: Text("No Jobs Found"));
              } else {
                final jobs = snapshot.data;

                return ListView.builder(
                    itemCount: jobs!.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var job = jobs[index];

                      return  JobVerticalTile(job: job,);
                    });
              }
            }),
        
        )
        :const NoSearchResults(text: "start Searching"),
    );
  }
}