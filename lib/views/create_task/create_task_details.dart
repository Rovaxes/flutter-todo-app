import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/app_text.dart';
import 'package:todo_app/providers/mission_model.dart';
import 'package:todo_app/providers/missions_model.dart';

class CreateTaskDetails extends StatefulWidget {
  const CreateTaskDetails({super.key});

  @override
  _CreateTaskDetailsState createState() => _CreateTaskDetailsState();
}

class _CreateTaskDetailsState extends State<CreateTaskDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget header = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
              text: "Mission Creation",
              textStyle: textTheme.displaySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary)),
          AppText(
              text: "What is this mission about?",
              textStyle: textTheme.bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary))
        ]);

    Widget missionTitleForm = Consumer<MissionModel>(
        builder: (context, mission, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(children: [
              AppText(
                  text: "What should we call this mission?",
                  textStyle: textTheme.bodyMedium!.copyWith()),
              const SizedBox(height: 8),
              TextField(
                style: textTheme.bodyMedium!.copyWith(),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: textTheme.bodyMedium!
                        .copyWith(color: Colors.grey.withOpacity(0.8)),
                    hintText: "Mission Title"),
                onChanged: (value) => mission.updateMissionName(value),
              ),
            ])));

    Widget missionDescriptionForm = Consumer<MissionModel>(
        builder: (context, mission, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(children: [
              AppText(
                  text: "What are the details of this mission?",
                  textStyle: textTheme.bodyMedium!.copyWith()),
              const SizedBox(height: 8),
              TextField(
                style: textTheme.bodyMedium!.copyWith(),
                maxLines: 6,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText:
                      "Ex: complete 100 pushups before the end of the day",
                  hintStyle: textTheme.bodyMedium!
                      .copyWith(color: Colors.grey.withOpacity(0.8)),
                ),
                onChanged: (value) => mission.updateMissionDescription(value),
              )
            ])));

    Widget missionRewardsSelection = Consumer<MissionModel>(
        builder: (context, mission, child) => Column(children: [
              AppText(
                  text: "How much expierence is this mission worth?",
                  textStyle: textTheme.bodyMedium!),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      FilterChip(
                        label: AppText(
                            text: "+10",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                color: mission.expierence == 10
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onTertiary)),
                        selected: mission.expierence == 10,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        onSelected: (value) {
                          if (value) {
                            mission.updateExpierence(10);
                          }
                        },
                        iconTheme: null,
                      ),
                      FilterChip(
                        label: AppText(
                            text: "+25",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                color: mission.expierence == 25
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onTertiary)),
                        selected: mission.expierence == 25,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        onSelected: (value) {
                          if (value) {
                            mission.updateExpierence(25);
                          }
                        },
                        iconTheme: null,
                      ),
                      FilterChip(
                          label: AppText(
                              text: "+50",
                              textStyle: textTheme.bodyMedium!.copyWith(
                                  color: mission.expierence == 50
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onTertiary)),
                          selected: mission.expierence == 50,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          onSelected: (value) {
                            if (value) {
                              mission.updateExpierence(50);
                            }
                          }),
                      FilterChip(
                          label: AppText(
                              text: "+100",
                              textStyle: textTheme.bodyMedium!.copyWith(
                                  color: mission.expierence == 100
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onTertiary)),
                          selected: mission.expierence == 100,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          onSelected: (value) {
                            if (value) {
                              mission.updateExpierence(100);
                            }
                          })
                    ],
                  ),
                )
              ])
            ]));

    Widget action = Consumer2<MissionsModel, MissionModel>(
        builder: (context, missions, mission, child) => FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (mission.missionType == MissionType.none ||
                          mission.missionName.isEmpty ||
                          mission.expierence <= 0) {
                        return Colors.grey.withOpacity(0.8);
                      }
                      return Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(1); // Use the component's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: mission.missionType == MissionType.none ||
                      mission.missionName.isEmpty ||
                      mission.expierence <= 0
                  ? null
                  : () {
                      missions.addMission(MissionModel(
                          missionName: mission.missionName,
                          missionCategory: MissionCategory.other,
                          missionDescription: mission.missionDescription,
                          missionType: mission.missionType,
                          expierence: mission.expierence));
                      GoRouter.of(context).pushReplacementNamed('home');
                    },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: AppText(
                      text: "Create Mission",
                      textStyle: textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary))),
            ));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Center(
            child: SizedBox(
                width: 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .pushReplacementNamed('create-task');
                      },
                      tooltip: 'Go Back',
                      child: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    const SizedBox(height: 24),
                    header,
                    const SizedBox(height: 24),
                    Card.outlined(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: Column(children: [
                              missionTitleForm,
                              const SizedBox(height: 12),
                              missionDescriptionForm,
                              const SizedBox(height: 12),
                              Row(children: [
                                Expanded(child: missionRewardsSelection)
                              ]),
                              const SizedBox(height: 12),
                            ]))),
                    const SizedBox(height: 24),
                    Row(children: [Expanded(child: action)]),
                  ],
                ))));
  }
}
