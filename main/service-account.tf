resource "yandex_iam_service_account" "netology-cluster-service-account" {
  name = "netology-cluster-service-account"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id  = yandex_iam_service_account.netology-cluster-service-account.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.netology-cluster-service-account.id}"
  depends_on = [yandex_iam_service_account.netology-cluster-service-account]
}
