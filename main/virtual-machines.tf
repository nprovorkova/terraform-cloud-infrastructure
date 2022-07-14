data "yandex_compute_image" "ubuntu-2004" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "control-plane-vm" {
  name     = format("control-plane-vm-%s", terraform.workspace)
  hostname = format("control-plane-vm-%s", terraform.workspace)
  zone     = local.zones.a.zone_name

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004.id
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public[local.zones.a.name].id
    nat       = true
  }

  scheduling_policy {
    preemptible = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker1-vm" {
  name     = format("worker1-vm-%s", terraform.workspace)
  hostname = format("worker1-vm-%s", terraform.workspace)
  zone     = local.zones.b.zone_name

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004.id
      size     = 100
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public[local.zones.b.name].id
    nat       = true
  }

  scheduling_policy {
    preemptible = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker2-vm" {
  name     = format("worker2-vm-%s", terraform.workspace)
  hostname = format("worker2-vm-%s", terraform.workspace)
  zone     = local.zones.c.zone_name

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004.id
      size     = 100
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public[local.zones.c.name].id
    nat       = true
  }

  scheduling_policy {
    preemptible = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
