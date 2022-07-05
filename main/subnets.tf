resource "yandex_vpc_subnet" "public" {
  for_each       = local.zones
  zone           = each.value.zone_name
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = each.value.public_subnet
}
