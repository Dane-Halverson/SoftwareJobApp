class JobTracker {
  String company;
  String position;
  double salary;
  DateTime postedDate;

  JobTracker(this.company, this.position, this.salary, this.postedDate);
}

class JobApplication {
  JobTracker opening;
  DateTime applicationDate;
  double confidenceLevel;

  JobApplication(this.opening, this.applicationDate, this.confidenceLevel);
}

List<JobTracker> jobTracker = [  JobTracker('Acme Corp', 'Software Engineer', 100000, DateTime(2023, 4, 30)),  JobTracker('Widgets Inc', 'Product Manager', 120000, DateTime(2023, 5, 1)),];

List<JobApplication> jobApplications = [  JobApplication(jobTracker[0], DateTime(2023, 5, 1), 0.8),
JobApplication(jobTracker[1], DateTime(2023, 5, 2), 0.9),

];
