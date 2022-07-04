resource "yandex_vpc_network" "vpc" {
  name = format("vpc-netology-%s", terraform.workspace)
}
