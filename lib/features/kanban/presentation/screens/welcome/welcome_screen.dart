import 'package:flutter/material.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/utils/assets.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/projects/create_project.screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(AppAssets.APP_ICON_TRANSPARENT),
                ),
                Text(
                  "Welcome to Task Manager! 🚀",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 25),
                ),
                Text(
                  "Let's get organized and productive together. Whether it's managing your to-dos, setting reminders, or prioritizing tasks, this app has got you covered. Ready to conquer your day? Let's dive in!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            )),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  AppRoutes.push(context, const CreateProjectScreen());
                },
                child: Text(
                  "Get Started",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
