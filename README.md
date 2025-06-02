# Level Up

This is a variation of the classic todo application and POC to explore providers. 

Features:
- Earn EXP to level up
- Create Tasks
- Update Tasks
- Delete Tasks
- Filter Tasks

## Releasing

Run the below commands

flutter clean
flutter pub get
flutter build web --release --base-href /flutter-todo-app/
cd build/web

Once completed create a release branch and delploy it via github pages