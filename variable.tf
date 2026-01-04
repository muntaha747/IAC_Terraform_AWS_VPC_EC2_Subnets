variable "Geo_Location" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ca-central-1"
}


variable "VPC_CLoud" {
  description = "AWS VPC region where resources will be created"
  type        = string
  default     = "10.20.0.0/16"
}

variable "AZ_1a" {
  description = "Availability Zone"
  type        = string
  default     = "ca-central-1a"
}

variable "AZ_1b" {
  description = "Availability Zone"
  type        = string
  default     = "ca-central-1b"
}


variable "Subnet_ID1" {
  description = "This Subnet inside VPC"
  type        = string
  default     = "10.20.1.0/24"

}


variable "Subnet_ID2" {
  description = "This Subnet inside VPC"
  type        = string
  default     = "10.20.2.0/24"
}


variable "Subnet_ID3" {
  description = "This Subnet inside VPC"
  type        = string
  default     = "10.20.3.0/24"
}


variable "Subnet_ID4" {
  description = "This Subnet inside VPC"
  type        = string
  default     = "10.20.4.0/24"
}

variable "EC2_Firewall" {
  description = "This Security Groupo inside VPC"
  type        = string
  default     = "TFPublicEC2SGS"
}

variable "Key_Pair" {
  description = "This Security Groupo inside VPC"
  type        = string
  default     = "VPC_CF"
}

variable "AMIID" {
  description = "RedHat-Linux"
  type        = string
  default     = "ami-0c223799415ea3182"
}




variable "EC2_Instance_Public" {
  description = "This Subnet inside VPC"
  type        = string
  default     = "t3.micro"
}

variable "EC2_Instance_Private" {
  description = "This Subnet inside VPC"
  type        = string
  default     = "t3.micro"
}