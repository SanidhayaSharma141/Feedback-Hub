Future<void> func() async {
  // final response =
  //     await http.get(Uri.parse('http://$host/api/courses'), headers: {
  //   'Authorization': 'Bearer ${settings.jwt}',
  // });
  // print(response.body);
  // return;
  // final courseList = [
  //   Course(
  //     id: 'MA101',
  //     instructors: [UserData(name: 'Dr. Alka Chaddha')],
  //     name: 'Mathematics 1',
  //     description:
  //         'Mathematics is a fundamental subject that is essential for many college majors, including engineering, computer science, economics, and statistics. The specific math courses that college students take will vary depending on their major and career goals. However, some of the most common math courses for college students include:\nCalculus\nLinear algebra\nProbability and statistics\nDifferential equations\nNumerical methods',
  //   ),
  //   Course(
  //     id: 'CS101',
  //     instructors: [UserData(name: 'Mr. John Doe')],
  //     name: 'Introduction to Computer Science',
  //     description:
  //         'Computer science is the study of computers and computational systems. It includes the study of algorithms, programming languages, data structures, operating systems, and artificial intelligence.',
  //   ),
  //   Course(
  //     id: 'ENG101',
  //     instructors: [UserData(name: 'Dr. Jane Smith')],
  //     name: 'Introduction to Engineering',
  //     description:
  //         'Engineering is the application of scientific principles to solve practical problems. It includes the study of mechanics, thermodynamics, electrical engineering, and civil engineering.',
  //   ),
  //   Course(
  //     id: 'PHY101',
  //     instructors: [UserData(name: 'Professor William Jones')],
  //     name: 'Introduction to Physics',
  //     description:
  //         'Physics is the study of matter and energy. It includes the study of mechanics, thermodynamics, electromagnetism, and quantum mechanics.',
  //   ),
  //   Course(
  //     id: 'STA101',
  //     instructors: [UserData(name: 'Ms. Mary Brown')],
  //     name: 'Introduction to Statistics',
  //     description:
  //         'Statistics is the study of data collection, analysis, interpretation, and presentation. It is used in many different fields, including business, economics, and healthcare.',
  //   ),
  //   Course(
  //     id: 'ECO101',
  //     instructors: [UserData(name: 'Dr. David Green')],
  //     name: 'Introduction to Economics',
  //     description:
  //         'Economics is the study of how people make choices under scarcity. It includes the study of microeconomics, macroeconomics, and international economics.',
  //   ),
  //   Course(
  //       id: 'CSE101',
  //       instructors: [UserData(name: 'Dr. Susan White')],
  //       name: 'Data Structures and Algorithms',
  //       description:
  //           'This course covers the fundamental data structures and algorithms used in computer science. Topics include arrays, linked lists, stacks, queues, trees, graphs, and sorting and searching algorithms.'),
  //   Course(
  //       id: 'CSE201',
  //       instructors: [
  //         UserData(name: 'Professor Michael Black'),
  //       ],
  //       name: 'Programming Languages',
  //       description:
  //           'This course introduces the different programming languages used in computer science. Topics include procedural programming, object-oriented programming, functional programming, and logic programming.'),
  //   Course(
  //       id: 'CSE301',
  //       instructors: [UserData(name: 'Ms. Sarah Green')],
  //       name: 'Operating Systems',
  //       description:
  //           'This course covers the fundamental concepts of operating systems. Topics include process management, memory management, file systems, and device drivers.'),
  //   Course(
  //       id: 'CSE401',
  //       instructors: [UserData(name: 'Dr. John Smith')],
  //       name: 'Computer Networks',
  //       description:
  //           'This course covers the fundamental concepts of computer networks. Topics include OSI model, TCP/IP model, routing, and switching.'),
  //   Course(
  //       id: 'CSE501',
  //       instructors: [UserData(name: 'Professor Jane Doe')],
  //       name: 'Artificial Intelligence',
  //       description:
  //           'This course covers the fundamental concepts of artificial intelligence. Topics include search, reasoning, planning, machine learning, and natural language processing.'),
  // ];
  // for (final course in courseList) {
  //   print('Updating Course: ${course.encode()}');
  //   final response = await http.post(Uri.parse('http://$host/api/courses'),
  //       body: json.encode({
  //         'data': course.encode(),
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${settings.jwt}',
  //       });
  //   print("response.body: ${response.body}");
  // }
}
