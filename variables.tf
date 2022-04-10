# define GCP region
variable "region" {
  type        = string
  description = "GCP region"
  default = "us-central1"
}
# define GCP zone
variable "zone" {
  type        = string
  description = "GCP zone"
  default = "us-central1-a"
}
# define GCP project name
variable "project" {
  type        = string
  description = "GCP project name"
  default = "involuted-woods-340900"
}
# GCP authentication file
// variable "gcp_auth_file" {
//   type        = string
//   description = "GCP authentication file"
// }
variable "bucket-name" {
  type        = string
  description = "The name of the Google Storage Bucket to create"
  default = "tf-backend-4321"
}
// variable "storage-class" {
//   type        = string
//   description = "The storage class of the Storage Bucket to create"
// }