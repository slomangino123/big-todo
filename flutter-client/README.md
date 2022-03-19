# helloworld

A new Flutter project.
Following Tutorial here https://www.youtube.com/watch?v=ly0hAtV7EBg&t=1294s&ab_channel=TechWithTim

## Swagger
[Github](https://github.com/epam-cross-platform-lab/swagger-dart-code-generator)

[Sample](https://github.com/epam-cross-platform-lab/swagger-dart-code-generator/tree/master/example)

To generate the client.
1. Copy swagger file into swagger_input/api.json
1. Delete files in swagger_output, for some reason it will not generate if files exist.
1. Run this command: `flutter pub run build_runner build --delete-conflicting-outputs`