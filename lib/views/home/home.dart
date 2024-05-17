import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:todo_app/components/app_text.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/providers/account_model.dart';
import 'package:todo_app/providers/mission_model.dart';
import 'package:todo_app/providers/missions_model.dart';
import 'package:todo_app/views/task/task_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;

  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true, period: const Duration(seconds: 1));

  late final Animation<Offset> _offsetAnimation =
      Tween<Offset>(begin: Offset.zero, end: const Offset(0.1, 0)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Color getCardColor(MissionType missionType) {
    switch (missionType) {
      case MissionType.daily:
        return AppColors.daily;
      case MissionType.weekly:
        return AppColors.weekly;
      case MissionType.monthly:
        return AppColors.monthly;
      case MissionType.regular:
        return AppColors.regular;
      default:
        return AppColors.daily;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget header =
        const Image(width: 340, image: AssetImage('assets/logo.png'));

    Widget level = Consumer<AccountModel>(
        builder: (context, account, child) => Card.outlined(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(children: [
                  Stack(alignment: Alignment.center, children: [
                    Ink(
                      decoration: const ShapeDecoration(
                        color: AppColors.secondary,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        iconSize: 32,
                        icon: const Icon(Icons.keyboard_double_arrow_up),
                        color: AppColors.white,
                        onPressed: () {},
                      ),
                    ),
                    Transform.scale(
                        scale: 1.5,
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          tween: Tween<double>(
                            begin: 0,
                            end: account.expierenceCurrent /
                                account.expierenceTotal,
                          ),
                          builder: (context, value, _) =>
                              CircularProgressIndicator(
                            value: value,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        ))
                  ]),
                  const SizedBox(width: 24),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        AppText(
                            text: "Level ${account.level}",
                            textStyle: textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        AppText(
                            text:
                                "${account.expierenceCurrent} out of ${account.expierenceTotal}",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.tertirary)),
                        const SizedBox(height: 10),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          tween: Tween<double>(
                            begin: 0,
                            end: account.expierenceCurrent /
                                account.expierenceTotal,
                          ),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                            minHeight: 8,
                            value: value,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        ),
                      ]))
                ]))));

    Widget mission(MissionModel mission, int index) => Material(
        child: InkWell(
            onTap: () {
              Provider.of<MissionModel>(context, listen: false)
                  .setMission(mission);
              _animationController.stop();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetails(index: index)),
              );
            },
            onTapDown: (a) {
              _animationController.animateBack(0);
              //_animationController.stop();
            },
            onTapUp: (a) {
              _animationController.repeat(reverse: true);
              _animationController.reset();
            },
            child: Card(
                key: UniqueKey(),
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // if you need this
                  side: BorderSide(
                    color: getCardColor(mission.missionType),
                    width: 1,
                  ),
                ),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      children: [
                        MaxWidthBox(
                            maxWidth: 200,
                            child: AppText(
                              text: mission.missionName,
                              textStyle: textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 4,
                            )),
                        const Spacer(),
                        Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // if you need this
                            side: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                          label: AppText(
                              text: "+${mission.expierence} exp",
                              textStyle: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary)),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        )
                      ],
                    )))));

    Widget missions = Consumer<MissionsModel>(
        builder: (context, missions, child) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AppText(
                        text: "Missions",
                        textStyle: textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 4,
                      children: [
                        FilterChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: getCardColor(MissionType.daily)),
                          ),
                          label: AppText(
                              text: "Daily",
                              textStyle: textTheme.titleMedium!.copyWith(
                                  color: missions.filters
                                          .contains(MissionType.daily)
                                      ? Colors.white
                                      : null)),
                          selected:
                              missions.filters.contains(MissionType.daily),
                          selectedColor: AppColors.daily,
                          onSelected: (value) {
                            if (value) {
                              missions.addFilter(MissionType.daily);
                            } else {
                              missions.removeFilter(MissionType.daily);
                            }
                          },
                          iconTheme: null,
                          showCheckmark: false,
                        ),
                        FilterChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: getCardColor(MissionType.weekly)),
                            ),
                            selectedColor: AppColors.weekly,
                            label: AppText(
                                text: "Weekly",
                                textStyle: textTheme.titleMedium!.copyWith(
                                    color: missions.filters
                                            .contains(MissionType.weekly)
                                        ? Colors.white
                                        : null)),
                            selected:
                                missions.filters.contains(MissionType.weekly),
                            onSelected: (value) {
                              if (value) {
                                missions.addFilter(MissionType.weekly);
                              } else {
                                missions.removeFilter(MissionType.weekly);
                              }
                            },
                            showCheckmark: false),
                        FilterChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: getCardColor(MissionType.monthly)),
                            ),
                            selectedColor: AppColors.monthly,
                            label: AppText(
                                text: "Monthly",
                                textStyle: textTheme.titleMedium!.copyWith(
                                    color: missions.filters
                                            .contains(MissionType.monthly)
                                        ? Colors.white
                                        : null)),
                            selected:
                                missions.filters.contains(MissionType.monthly),
                            onSelected: (value) {
                              if (value) {
                                missions.addFilter(MissionType.monthly);
                              } else {
                                missions.removeFilter(MissionType.monthly);
                              }
                            },
                            showCheckmark: false),
                        FilterChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: getCardColor(MissionType.regular)),
                            ),
                            selectedColor: AppColors.regular,
                            label: AppText(
                                text: "Regular",
                                textStyle: textTheme.titleMedium!.copyWith(
                                    color: missions.filters
                                            .contains(MissionType.regular)
                                        ? Colors.white
                                        : null)),
                            selected:
                                missions.filters.contains(MissionType.regular),
                            onSelected: (value) {
                              if (value) {
                                missions.addFilter(MissionType.regular);
                              } else {
                                missions.removeFilter(MissionType.regular);
                              }
                            },
                            showCheckmark: false)
                      ],
                    ),
                  ),
                  if (missions.missions.isEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 4),
                      child: AppText(
                          text:
                              "No new missions available today! If you would like to add more select the floating create option below.",
                          textAlign: TextAlign.center,
                          textStyle: textTheme.titleMedium!
                              .copyWith(color: Colors.grey)),
                    )
                  ],
                  Column(
                    children: [
                      for (final (int index, MissionModel currentMission)
                          in missions.missions
                              .where((mission) =>
                                  missions.filters
                                      .contains(mission.missionType) ||
                                  missions.filters.isEmpty)
                              .indexed) ...[
                        Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          background: Center(
                              child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                AppText(
                                    text: "Swipe right to complete mission",
                                    textStyle: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary)),
                                const Icon(Icons.chevron_right),
                              ])), // Background for swipe right
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              Provider.of<AccountModel>(context, listen: false)
                                  .gainExpierence(50, () {
                                _confettiController.play();
                              });
                            }
                            _animationController.reset();
                            _animationController.repeat(reverse: true);
                            missions.removeMissionAtIndex(index);
                          },
                          child: index == 0
                              ? SlideTransition(
                                  position: _offsetAnimation,
                                  child: mission(currentMission, index))
                              : mission(currentMission, index),
                        ),
                      ],
                    ],
                  )
                ]));

    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                  0.5,
                  1
                ],
                    colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.2),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                ])),
            child: Center(
                child: MaxWidthBox(
                    maxWidth: 400,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Column(children: [
                        const SizedBox(height: 24),
                        header,
                        const SizedBox(height: 24),
                        level,
                        const SizedBox(height: 24),
                        missions
                      ]),
                    )))),
        Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2,
              emissionFrequency: 0.2,
              numberOfParticles: 20,
              blastDirectionality: BlastDirectionality.explosive,
              gravity: 0.1,
              colors: const [
                AppColors.tertirary,
                AppColors.white,
                AppColors.regular,
                AppColors.secondary,
                AppColors.daily
              ],
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushReplacementNamed('create-task');
        },
        tooltip: 'Add a mission',
        child: const Icon(Icons.create),
      ),
    );
  }
}
