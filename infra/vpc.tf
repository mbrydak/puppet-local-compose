resource "google_compute_network" "puppet_docker_compose" {
  name                    = "puppet-docker-compose"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "puppet_docker_compose" {
  name          = "puppet-docker-compose"
  ip_cidr_range = "10.240.0.0/24"
  region        = var.region
  network       = google_compute_network.puppet_docker_compose.id
}

resource "google_compute_firewall" "puppet_docker_compose_allow_internal" {
  name    = "puppet-docker-compose-allow-internal"
  network = google_compute_network.puppet_docker_compose.id

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  source_ranges = var.internal_cidr_range
}

resource "google_compute_firewall" "puppet_docker_compose_allow_external" {
  name    = "puppet-docker-compose-allow-external"
  network = google_compute_network.puppet_docker_compose.id

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "puppet_docker_compose_external_lb_ip" {
  name = "puppet-docker-compose-external-lb-ip"
}