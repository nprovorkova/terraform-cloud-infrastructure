### Создание облачной инфраструктуры
#### Предварительная подготовка к установке и запуску Kubernetes кластера.
* Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя
* Подготовьте backend для Terraform:
  <br>&nbsp; &nbsp; а. Рекомендуемый вариант: Terraform Cloud
  <br>&nbsp; &nbsp; б. Альтернативный вариант: S3 bucket в созданном ЯО аккаунте
* Настройте workspaces
  <br>&nbsp; &nbsp; а. Рекомендуемый вариант: создайте два workspace: stage и prod. В случае выбора этого варианта все последующие шаги должны учитывать факт существования нескольких workspace.
  <br>&nbsp; &nbsp; б. Альтернативный вариант: используйте один workspace, назвав его stage. Пожалуйста, не используйте workspace, создаваемый Terraform-ом по-умолчанию (default).
* Создайте VPC с подсетями в разных зонах доступности.
* Убедитесь, что теперь вы можете выполнить команды terraform destroy и terraform apply без дополнительных ручных действий.
* В случае использования Terraform Cloud в качестве backend убедитесь, что применение изменений успешно проходит, используя web-интерфейс Terraform cloud.

#### Ожидаемые результаты:
* Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий.
* Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

### Создание Kubernetes кластера
#### Самостоятельная установка Kubernetes кластера.
* При помощи Terraform подготовить как минимум 3 виртуальных машины Compute Cloud для создания Kubernetes-кластера. Тип виртуальной машины следует выбрать самостоятельно с учётом требовании к производительности и стоимости.

### Создание тестового приложения
#### Подготовка тестового приложения, эмулирующего основное приложение разрабатываемое вашей компанией
* В качестве регистра может быть DockerHub или Yandex Container Registry, созданный также с помощью terraform.

#### Команды:
Выполняем terraform apply для директории _prepare, 
<br>копируем access_key и secret_key (terraform output secret_key) в main.tf
<br>затем terraform apply для директории main
<br><br>export YC_TOKEN="***"
<br>terraform init
<br>terraform workspace new stage
<br>terraform workspace new prod
<br>terraform workspace list
<br>terraform workspace select stage
<br>terraform validate
<br>terraform fmt
<br>terraform plan
<br>terraform apply

<br>Копируем файл, содержащий ip-адреса виртуальных машин в Kubespray
<br><br>cp ../tf_nodes_ip.yml ../../kubespray-netology-graduation-project/netology-cluster/group_vars/all/tf_nodes_ip.yml
<br>terraform output -json netology_registry_service_account_key |docker login --username json_key --password-stdin cr.yandex
<br>cat ~/.docker/config.json
<br><br>Вы создаёте по отдельному балансировщику на каждый сервис (grafana и тестовое приложение), но можно сэкономить ресурсы, создать только один балансировщик и использовать в kubernetes Ingress на основе nginx. Так чаще всего и строятся реальные системы.

