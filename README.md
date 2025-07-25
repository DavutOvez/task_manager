# Task Manager App (Flutter)

## Overview

Task Manager is a simple Flutter application that allows users to manage their daily tasks. Users can add new tasks with a title, date, and priority level, update existing tasks, or delete tasks. The app also supports marking tasks as completed.

## Features

- Add new tasks with title, date picker, and priority selection
- Update existing tasks or delete them
- Mark tasks as completed with a checkbox
- Date selection through an interactive calendar
- Clean and intuitive user interface

## Project Structure

- **main.dart**  
  Main screen displaying the list of tasks with options to add, update, or delete tasks.

- **add.dart (AddTaskPage)**  
  Page to add a new task. Includes form fields for title, date, and priority, and validation for input completeness.

- **update.dart (UpdateorDeleteTask)**  
  Page to update or delete an existing task. Fields are pre-filled with the current task data.

## How to Run

1. Make sure you have Flutter installed and set up on your machine.
2. Clone or download the project.
3. Run the app using the command:  
   ```bash
   flutter run
