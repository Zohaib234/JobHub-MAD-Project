import 'package:flutter/material.dart';
import 'package:jobhubv2_0/controllers/agent_provider.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/services/helpers/agent_helper.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/uploaded_tile.dart';
import 'package:provider/provider.dart';

class AgentJobs extends StatefulWidget {
  const AgentJobs({super.key});

  @override
  State<AgentJobs> createState() => _AgentJobsState();
}

class _AgentJobsState extends State<AgentJobs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AgentNotifier>(builder: (context, agentnotifier, child) {
      var agentjobs = AgentHelper.getAgentJobs(agentnotifier.agent!.uid);
      return FutureBuilder<List<JobsResponse>>(
          future: agentjobs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: PageLoader());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.data!.isEmpty) {
              return Center(child: Text("No Jobs Found"));
            } else {
              final jobs = snapshot.data;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: ListView.builder(
                    itemCount: jobs!.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var job = jobs[index];

                      return UploadedTile(
                        job: job,
                      );
                    }),
              );
            }
          });
    });
  }
}
