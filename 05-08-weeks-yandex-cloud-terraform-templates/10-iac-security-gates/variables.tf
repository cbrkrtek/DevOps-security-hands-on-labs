variable "folder_id" { type = string }
variable "ssh_public_key" { type = string }

variable "environment_profiles" {
  type = map(object({
    instance_cores  = number
    instance_memory = number
    boot_disk_size  = number
    sub_cidr        = string
  }))
  default = {
    dev = {
      instance_cores  = 2
      instance_memory = 2
      boot_disk_size  = 15
      sub_cidr        = "10.180.1.0/24"
    }
    prod = {
      instance_cores  = 4
      instance_memory = 4
      boot_disk_size  = 30
      sub_cidr        = "10.190.1.0/24"
    }
  }
}