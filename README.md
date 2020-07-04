# for_test
<h1> 8. Практика IaC с использованием Terraform  </h1>
<h2> 8.1 Сборка образов VM при помощи Packer</h2>
Изучена документация terraform 
Определаны input переменные 
Отформатированы все файлы через `terraform fmt`
Создан файл terraform.tfvars.example с примерами переменных
Создан файл lb.tf для *Load Balancer*, через outputs.tf выведены ip адреса инстансов и load balancer
Проверена работоспособность LB с несколькими аппами. Проверена работоспособность LB при выключении сервиса на одном из аппов.
Дополнен main.tf для возможности создавать n инстансов с приложениями, через изменение значения app_instances_count (в текущей конфигурации максимум 3 инстанса минимум 1), для создания большего числа инстансов необходимо внести изменения в outputs.tf
Создание инстансов: `terraform apply -auto-approve`

```
$ terraform apply -auto-approve
....
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

external_ip_address_app-1 = 130.193.50.49
external_ip_address_app-2 = 130.193.37.100
external_ip_address_app-3 = 130.193.36.65
reddit-balancer-address = [
  "84.201.159.22",
]
```
