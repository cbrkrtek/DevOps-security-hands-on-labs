variable "instance_name"{
    type = string
    description = "Name of the VM intance"
}

variable "subnet_id"{
    type = string
    description = "Subnet ID to attach the instance to"
}

variable "ssh_public_key"{
    type = string
    description = "Public key for SSH user"
    validation {
    condition     = can(regex("^ssh-(rsa|ed25519)", var.ssh_public_key))
    error_message = "The SSH public key must start with a valid standard prefix (ssh-rsa or ssh-ed25519)."
  }
}