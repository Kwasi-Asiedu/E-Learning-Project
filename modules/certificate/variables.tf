variable "domain" {
  description = "Domain"
  type        = string
}

variable "subject_alternative_names" {
  description = "Alternate domain names"
  type        = list(string)
}