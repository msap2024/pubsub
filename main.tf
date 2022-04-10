provider "google-beta" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google" {
  project = var.project
  region  = var.region
}
resource "google_pubsub_topic" "example" {
  name = "example-topic"
  message_storage_policy {
    allowed_persistence_regions = [
      "us-central1",
    ]
  }
  kms_key_name = google_kms_crypto_key.crypto_key.id
  depends_on = [google_pubsub_schema.example]
  schema_settings {
    schema = "projects/involuted-woods-340900/schemas/example"
    encoding = "JSON"
  }

  labels = {
    foo = "bar"
  }

  message_retention_duration = "86600s"
}
resource "google_pubsub_schema" "example" {
  name = "example"
  type = "AVRO"
  definition = "{\n  \"type\" : \"record\",\n  \"name\" : \"Avro\",\n  \"fields\" : [\n    {\n      \"name\" : \"StringField\",\n      \"type\" : \"string\"\n    },\n    {\n      \"name\" : \"IntField\",\n      \"type\" : \"int\"\n    }\n  ]\n}\n"
}
resource "google_kms_crypto_key" "crypto_key" {
  name     = "example-key6"
  key_ring = google_kms_key_ring.key_ring.id
}

resource "google_kms_key_ring" "key_ring" {
  name     = "example-keyring6"
  location = "global"
}

resource "google_pubsub_subscription" "example1" {
  name  = "example-push-subscription"
  topic = google_pubsub_topic.example.name

  ack_deadline_seconds = 20

  labels = {
    foo = "bar"
  }

  push_config {
    push_endpoint = "https://example.com/push"

    attributes = {
      x-goog-version = "v1"
    }
  }
}

resource "google_pubsub_subscription" "example" {
  name  = "example-pull-subscription"
  topic = google_pubsub_topic.example.name

  labels = {
    foo = "bar"
  }

  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true

  ack_deadline_seconds = 20

  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }

  enable_message_ordering    = false
}

