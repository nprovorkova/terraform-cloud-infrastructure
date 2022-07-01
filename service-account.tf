resource "yandex_iam_service_account" "service-account" {
  name = "netology-service-account"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id  = yandex_iam_service_account.service-account.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.service-account.id}"
  depends_on = [yandex_iam_service_account.service-account]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.service-account.id
  description        = "static access key for object storage"
  depends_on         = [yandex_iam_service_account.service-account]
}


