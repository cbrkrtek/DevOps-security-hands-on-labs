output "subnet_id"{
    value = yandex_vpc_subnet.this.id
    description = "ID of the created subnet"
}
