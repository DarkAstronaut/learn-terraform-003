variable "bucket_name" {
  description = "Name for the S3 Bucket"
  type        = string
  default     = "tf-demo-bucket-17082025"
}

variable "tags" {
  description = "A Map of Tags for the S3 Bucket"
  type        = map(string)
  default = {
    Name        = "tf-course-demo-101"
    Environment = "Development"
  }
}


# Example for Sensitive Data

variable "database_pw" {
  type = string
  description = "Sensitive Data for Database"
   # sensitive = true
}

# Datatype Examples

# String
variable "server_name" { # server_name is of String Type
  type = string
  description = "Name of the Server"
  default = "web_server_1"
}

# Boolean
variable "enable_feature" { # enable_feature is Boolean Type
  type = bool
  description = "Enable or Disable Feature"
  default = true
}

# Number
variable "instance_count" { # instance_count in Number Type, can include Whole Numbers and Decimals
    type = number
    description = "Number of Server Instances"
    default = 3
}

# List
variable "my_list" { # my_list is a list of Strings
  type = list(string)
  description = "Sample List of String Type"
  default = [ "val1","val2","3","val4","5" ]
}

# List of any type
variable "multi_type_list" { # multi_type_list has any primitive type list
  type = list(any)
  description = "List of any Type"
  default = [ "First", 2, "Three", false, "Five", 6.02]
}

# Map
variable "my_map" {
  type = map(string)
  description = "Map Representing Key-Value Pair"
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}
// Key is field name and Value of the assigned value
// Mainly used for parameter settings 

# Set
variable "my_set" {
  type = set(string)
  default = [ "value1", "value2", "value3" ] # Each Value should be unique
} 

# Object
variable "user" {
    type = object({
      name = string
      email = string
      age = number
    }) 
}
// Used for Inputs and Outputs

# Tuple - sequence of values with their own type
variable "Example_tuple" {
    type = tuple([ string, number, bool ])
}
// USed for Functions or Modules