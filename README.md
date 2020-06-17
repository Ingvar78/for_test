# for_test
#ДЗ знакомство с облачной инфраструктурой
bastion_IP = 84.201.157.235
someinternalhost_IP=10.130.0.17
#Самостоятельное задание
#способ подключение к someinternalhost одной командой 
###Опции ssh: -A пробрасывает авторизацию на удалённый сервер. -J - Jumphost, -l - login name
[проброс по SSH](https://itsecforu.ru/2018/11/29/%D0%BA%D0%B0%D0%BA-%D0%BF%D0%BE%D0%BB%D1%83%D1%87%D0%B8%D1%82%D1%8C-%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF-%D0%BA-%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%BC%D1%83-%D1%81%D0%B5%D1%80%D0%B2/)
ssh -J  appuser@<bastion_IP> appuser@<someinternalhost_IP>
**OR**  
ssh -l appuser -A -J appuser@84.201.157.235 <someinternalhost_IP>

###подключение по hostname путем настройки .ssh/config
```
Host someinternalhost
     HostName <someinternalhost_IP>
     User <appuser>
     ProxyCommand ssh -W %h:%p <appuser>@<bastion_IP>
```


