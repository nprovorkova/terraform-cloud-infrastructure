resource "yandex_storage_bucket" "netology-graduation-project-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  depends_on = [yandex_iam_service_account_static_access_key.sa-static-key]
  bucket     = "netology-graduation-project-bucket"
  acl        = "public-read"
}
