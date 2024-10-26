

import 'package:flutter/material.dart';
import 'package:jobhubv2_0/models/request/agents/agents.dart';
import 'package:jobhubv2_0/services/helpers/agent_helper.dart';

class AgentNotifier extends ChangeNotifier {

  late List<Agents> allAgents;
  Agents? agent;
  late Map<String , dynamic> chat;

  void setAgent(Agents? agent) {
    this.agent = agent;
    notifyListeners();
  }
  get getagent=> agent;

  Future<List<Agents>> getAllAgents(){

    var agents = AgentHelper.getAgents();
    notifyListeners();
    return agents;
  }

}