import 'dart:io'; // For file handling

class Job {
  int jobId;
  String jobTitle;
  String jobDescription;
  String jobTypeEnum;
  String? documentUrl;
  File? document;

  Job({
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobTypeEnum,
    this.documentUrl,
    this.document,
  });

  // Convert a JSON Map into a Job instance
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['jobId'],
      jobTitle: json['jobTitle'] ?? '',
      jobDescription: json['jobDecription'] ?? '',
      jobTypeEnum: json['jobTypeEnum'] ?? '',
      documentUrl: json['documentUrl'],
      document: json['document'] != null ? File(json['document']) : null,
    );
  }

  // Convert a Job instance into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'jobTitle': jobTitle,
      'jobDecription': jobDescription,
      'jobTypeEnum': jobTypeEnum,
      'documentUrl': documentUrl,
      'document': document?.path,
    };
  }
}
