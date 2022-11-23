resource "google_compute_instance" "puppetvm" {
  count        = 1
  name         = "puppet-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone
  network_interface {
    subnetwork = google_compute_subnetwork.puppet_docker_compose.name
    network_ip = "10.240.0.${count.index + 10}"
    access_config {}
  }
  can_ip_forward = true
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  service_account {
    scopes = var.puppet_service_account_scope
  }

  tags = ["puppet-docker-compose", "puppet"]
}