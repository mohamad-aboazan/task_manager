Sure, here's a draft for the documentation:
# Task Manager Flutter Project

Welcome to the Task Manager Flutter project! This guide will help you get started with setting up and running the project on your local machine.

## Prerequisites

Ensure you have the following tools installed:

- Flutter SDK version 3.22.2
- Dart version 3.4.3
- DevTools version 2.34.3

If you haven't installed Flutter yet, you can follow the official installation guide [here](https://flutter.dev/docs/get-started/install).

## Getting Started

Follow these steps to get the project up and running:

### 1. Clone the Repository

First, clone the project repository from GitHub:

```bash
git clone https://github.com/mohamad-aboazan/task_manager
cd task_manager
flutter pub get
flutter run

## Obtaining the APK Version

To retrieve the latest APK version, you'll need to push the code to trigger the CI/CD pipeline. After pushing the code, please add your email to the workflow file (`codemagic.yaml`) and wait for approximately 5 minutes. You will receive an email containing the latest version of the APK.


# Task Manager Architecture


**THINK** first, then **ACT**.

## A short description about "Clean Architecture"

![architecture](./art/arch_1.png?raw=true)

There are two main points to understand about the architecture: it splits the project into different layers and conforms to the Dependency rule.

The number of layers used can vary slightly from one project to another, but by utilizing them, we promote the principle of 'separation of concerns.' If you're a new developer and have never heard of it before, it's simply a fancy way of saying, 'Hey! I'm a layer, and I'm concerned about a single aspect of the system only'. If a layer is responsible for displaying the UI, it won't handle database operations. Conversely, if a layer is responsible for data persistence, it won't have any knowledge of UI components

And what about the Dependency rule? Let's put it in simple terms. First, you need to understand that the layers discussed above are not stacked on top of each other; instead, they resemble the layers of an 'onion.' There is a central layer surrounded by outer layers. The Dependency rule states that classes within a layer can only access classes from their own layer or the outer layers, but never from the inner layers

Usually, when working with this architecture, you'll come across some additional terminology such as Entities, Interface Adapters, Use Cases, DTOs, and other terms. These terms are simply names given to components that also fulfill 'single responsibilities' within the project:

- Entities: Represent the core business objects, often reflecting real-world entities. Examples include Character, Episode, or Location classes. These entities usually correspond to real-world concepts or objects, possessing **_properties_** specific to them and encapsulating behavior through their own **_methods_**. You'll be **_reading, writting, and transforming entities throughout the layers_**

- Interface Adapters: Also known as Adapters, they're responsible for bridging the gap between layers of the system, **_facilitating the conversion and mapping of data between layers_**. There are various approaches available, such as specialized mapper classes or inheritance. The point is, by using these adapters, each layer can work with data in a format that suits better for its needs. As data moves between layers, it is mapped to a format that is suitable for the next layer. Thus, any future changes can be addressed by modifying these adapters to accommodate the updated format without impacting the layer's internals

- Use Cases: Also known as Interactors, **_they contain the core business logic and coordinate the flow of data_**. For example, they handle user login/logout, data saving or retrieval, and other functionalities. Use Case classes are typically imported and used by classes in the presentation (UI) layer. They also utilize a technique called 'inversion of control' to be independent of the data retrieval or sending mechanism, while coordinating the flow of data

- Data Transfer Objects (DTOs): Are objects used for transferring data between different layers of the system. They serve as _**simple containers that carry data**_ without any behavior or business logic

I recommend checking out [this link](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), provided by Robert C. Martin ('Uncle Bob'), which offers what today may be considered the 'official' explanation



## Clean Architecture and how it's applied in this project

The figure bellow represents the variation applied in this project:

![architecture](./art/arch_2.png?raw=true)

In this case, we're only using three layers: Presentation, Domain and Data.

### The presentation layer (UI)

This is the layer where the Flutter framework resides. Here, you'll find classes that are part of the framework, such as Widgets, BuildContexts, and libraries that consume the framework, including state management libraries.

Typically, the classes in this layer are responsible for:

- Managing the application's state.
- Handling UI aspects of an app, such as managing page navigation, displaying data, implementing internationalization, and ensuring proper UI updates.

### The domain layer

This layer represents the core domain of the problem we are addressing, encompassing the business rules. Hence, it should be an independent Dart module without dependencies on external layers. It includes:

- Plain entity classes (like Character entity)
- Use-case classes that encapsulate the specific business logic for a given use case (like GetAllCharacters, SignInUser, and others...)
- Abstractions for data access, normally repository or services interfaces

A use-case has no knowledge of the data source, whether it comes from a memory cache, local storage, or the internet. All these implementation details have been abstracted out through the use of Repository Interfaces. From the use-case's perspective, all that matters is that it receives the required data.

### The data layer

This layer serves as a boundary between our application and the external world. Its primary responsibility is to load data from external sources, such as the internet or databases, and convert it to a format that aligns with our Domain expectations. It plays a vital role in supplying data to the use cases and performs the following tasks:

- Data retrieval: It makes network and/or database calls, retrieving data from the appropriate data sources.
- Repository implementations: It includes the implementations of the repositories defined in the domain layer, providing concrete functionality for accessing and manipulating data.
- Data coordination: It coordinates the flow of data between multiple sources. For example, it can fetch data from the network, store it locally, and then return it to the use case.
- Data (de)serialization: It handles the conversion of data to and from JSON format, transforming it into Data Transfer Objects (DTOs) for standardized representation.
- Caching management: It can incorporate caching mechanisms, optimizing performance by storing frequently accessed data for quicker retrieval.

### The DTOs, Entities and States

As mentioned previously, this architecture emphasizes two fundamental principles: 'Separation of Concerns' and 'Single Responsibility.' And to uphold these principles, it is crucial to allow each layer to effectively handle data according to its specific needs. This can be achieved by utilizing classes with specialized characteristics that empower their usage within each layer.

In this project, the Data layer employs Data Transfer Objects (DTOs), the Domain layer utilizes Entities, and the Presentation layer the States classes.

DTOs are specifically designed for deserializing and serializing data when communicating with the network. Hence, it is logical for them to possess the necessary knowledge of JSON serialization. Entities, on the other hand, represent the core concepts of our domain and contain 'plain' data or methods relevant to their purpose. Lastly, in the Presentation layer, States are used to represent the way we display and interact with the data in the user interface.

The specific usage of these classes may vary from project to project. The names assigned to them can differ, and there can even be additional types of classes, such as those specifically designed for database mapping. However, the underlying principle remains consistent: By utilizing these classes alongside mappers, we can provide each layer with a suitable data format and the flexibility to adapt to future changes.

# References

- [Joe Birch - Google GDE: Clean Architecture Course](https://caster.io/courses/android-clean-architecture)
- [Reso Coder - Flutter TDD Clean Architecture](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech)
- [Majid Hajian | Flutter Europe - Strategic Domain Driven Design to Flutter](https://youtu.be/lGv6KV5u75k)
- [Guide to app architecture - Jetpack Guides](https://developer.android.com/jetpack/docs/guide#common-principles)
- [ABHISHEK TYAGI - TopTal Developer: Better Android Apps Using MVVM with Clean Architecture](https://www.toptal.com/android/android-apps-mvvm-with-clean-architecture)
- [Jason Taylor (+20 years of experience) - Clean Architecture ](https://youtu.be/Zygw4UAxCdg)
- [Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
---

# Kanban Feature Documentation

## Overview

The Kanban feature in the task manager application facilitates organizing tasks into columns for better visualization and management. This documentation provides an overview of the key components, including data sources, repositories, use cases, and presentation logic.

## Components

### Data Sources

1. **Remote Data Sources**
   - **ColumnRemoteDataSource**: Responsible for fetching and creating columns remotely via API calls.
   - **CommentRemoteDataSource**: Handles remote operations related to comments on tasks, such as fetching, creating, updating, and deleting comments.
   - **ProjectRemoteDataSource**: Manages remote operations for projects, including fetching and creating projects.
   - **TaskRemoteDataSource**: Handles remote CRUD operations for tasks, including fetching, creating, updating, and deleting tasks.

2. **Local Data Sources**
   - **TaskLocalDataSource**: Handles local storage operations for tasks, including caching tasks locally.
   - **TaskLogLocalDataSource**: Manages local storage of task log histories.

### Repositories

1. **Repositories**
   - **ColumnRepositoryImpl**: Implements the ColumnRepository interface, handling business logic related to columns.
   - **CommentRepositoryImpl**: Implements the CommentRepository interface, managing operations related to comments.
   - **ProjectRepositoryImpl**: Implements the ProjectRepository interface, handling project-related operations.
   - **TaskLogRepositoryImp**: Implements the TaskLogRepository interface, managing task log histories.
   - **TaskRepositoryImpl**: Implements the TaskRepository interface, handling tasks-related operations.

### Use Cases

1. **Column Use Cases**
   - **CreateColumnUsecase**: Handles the creation of columns.
   - **GetColumnsUsecase**: Retrieves columns for display.

2. **Comment Use Cases**
   - **CreateCommentUsecase**: Handles the creation of comments on tasks.
   - **DeleteCommentUsecase**: Manages the deletion of comments.
   - **GetCommentsUsecase**: Retrieves comments for display.
   - **UpdateCommentUsecase**: Manages updating comments.

3. **Project Use Cases**
   - **CreateProjectUsecase**: Handles the creation of projects.
   - **GetProjectUsecase**: Retrieves project details.
   - **GetProjectsUsecase**: Retrieves projects for display.

4. **Task Log Use Cases**
   - **GetTasksLogsUescas**: Retrieves task log histories.
   - **NewTaskLogUsecase**: Manages the creation of task log entries.

5. **Task Use Cases**
   - **CreateTaskUsecase**: Handles the creation of tasks.
   - **DeleteTaskUsecase**: Manages the deletion of tasks.
   - **GetTaskUsecase**: Retrieves task details.
   - **GetTasksUsecase**: Retrieves tasks for display.
   - **UpdateTaskUsecase**: Manages updating tasks.

### Presentation Logic

1. **Cubits**
   - **ColumnCubit**: Manages state related to columns.
   - **CommentCubit**: Manages state related to comments.
   - **NotificationCubit**: Handles state related to notifications.
   - **ProjectCubit**: Manages state related to projects.
   - **TaskCubit**: Handles state related to tasks.
   - **ThemeCubit**: Manages state related to app themes.
   - **TimerCubit**: Handles state related to timers.
Sure, here's an extension to the documentation covering the presentation layer, screens, and widgets:

## Presentation Layer

The presentation layer of the Kanban feature encompasses screens, widgets, and state management using Cubits. This layer is responsible for rendering user interfaces, handling user interactions, and managing application state.

### Screens

1. **Welcome Screen**: The initial screen that users see upon opening the app, providing a brief introduction or sign-in options.
2. **Home Screen**: Serves as the central hub of the application, offering navigation to various sections such as projects, notifications, settings, etc.
3. **Project Screen**: Displays a list of projects and allows users to create new projects.
4. **Column Screen**: Renders a Kanban board with columns representing different stages of task progression.
5. **Task Screen**: Shows details of individual tasks and allows users to create, update, and delete tasks.
6. **Notification Screen**: Displays notifications or alerts related to tasks, projects, or other activities within the app.
7. **Settings Screen**: Allows users to customize app preferences, manage account settings, and adjust other configuration options.
8. **Create Column Screen**: Offers functionality to create a new column within a Kanban board, specifying its name, position, and other attributes.
9. **Create Project Screen**: Provides a form or interface for users to create a new project, including details such as name, description, members, etc.
10. **Task History Screen**: Shows a log or history of activities related to tasks, such as creation, updates, assignments, comments, etc.
11. **View and Update Task Screen**: Allows users to view detailed information about a specific task and perform actions such as editing task details, marking as completed, assigning to users, etc.

### Widgets

1. **Project Widget**: Represents a project card with project details and options for editing and deleting.
2. **Column Widget**: Renders a column in the Kanban board, displaying tasks within that column.
3. **Task Widget**: Represents a task card within a column, showing task details and options for editing and deleting.
4. **Comment Widget**: Displays a comment within the task details screen, allowing users to view, edit, or delete comments.
5. **Notification Widget**: Displays notifications for task reminders or updates.
5. **Task Card**: Represents a task card with project details 
5. **Draggable Task Card**: Represents a draggable task card with project details 
5. **Color Picker Dialog**:  Provides options for picking a color
6. **Theme Switch Widget**: Provides options for switching between light and dark themes.

## Conclusion

The Kanban feature's architecture includes well-structured components, separating concerns for data handling, business logic, and presentation. This modular design enhances maintainability, scalability, and testability of the application.
