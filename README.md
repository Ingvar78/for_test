# for_test
Ingvar78_infra

hw11 Lecture 14

В процессе сделано:
- Установлен Vagrant и VirtualBox на локальной машине(linux - Centos 8).
- Доработаны роли Ansible и выполнен провижининг.
- Приложение установлено и работает на порту 9292
- сделано и активировано виртуальное окружение
- Установлены фреймворк для тестирования Ansible-кода TestInfra и инструмент тетирования molecule.
- Создан тест в roles/db/molecule/default/tests/test_default.py:

def test_socket_listening(host):
socket = host.socket('tcp://0.0.0.0:27017')
assert socket.is_listening

- Изменен verifier в файле roles/db/molecule/default/molecule.yml (по умолчанию Ansible):

```
verifier:
#  name: ansible 
   name: testinfra  
```

- Пройден цикл тестирования для роли db, пример вывода в ReadMe.md.

molecule create
molecule converge
molecule verify -- запускает тест test_default.py

- Переписаны плейбуки packer_db.yml, packer_app.yml с использованием ролей db,app. 
- Изменены шаблоны для packer/app.json, packer/db.json. 
- Пересобраны образы packer. 

Задание со (*)

- Для настройки проксирования добавлет параметр в ansible.extra_vars в Vagrantfile:

<pre><font color="#4E9A06">      ansible.extra_vars = {</font>
<font color="#4E9A06">        &quot;deploy_user&quot; =&gt; &quot;ubuntu&quot;,</font>
<font color="#4E9A06">        &quot;nginx_sites&quot; =&gt; {</font>
<font color="#4E9A06">          &quot;default&quot; =&gt; [</font>
<font color="#4E9A06">            &quot;listen 80&quot;,</font>
<font color="#4E9A06">            &quot;server_name &apos;reddit&apos;&quot;,</font>
<font color="#4E9A06">            &quot;location / { proxy_pass http://127.0.0.1:9292; }&quot;</font>
<font color="#4E9A06">          ]</font>
<font color="#4E9A06">        }</font>
</pre>

	
Как запустить проект:



____________________________________________________________________________________________________________


<h1>14. Разработка и тестирование Ansible ролей и плейбуков </h1>

<h2>14.1 Локальная разработка при помощи Vagrant, доработка ролей для провижининга в Vagrant </h2>

<h2>14.2 Тестирование ролей при помощи Molecule и Testinfra </h2>

<h2>14.3 Переключение сбора образов пакером на использование ролей </h2>

<h2>14.4 Результат работы </h2>

<pre><font color="#4E9A06">molecule converge</font>
<font color="#4E9A06">--&gt; </font><font color="#06989A">Test matrix</font>
    
└── default
    ├── dependency
    ├── create
    ├── prepare
    └── converge
    
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;dependency&apos;</font>
<font color="#C4A000">Skipping, missing the requirements file.</font>
<font color="#C4A000">Skipping, missing the requirements file.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;create&apos;</font>
<font color="#C4A000">Skipping, instances already created.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;prepare&apos;</font>
<font color="#C4A000">Skipping, instances already prepared.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;converge&apos;</font>
    
    PLAY [Converge] ****************************************************************
    
    TASK [Gathering Facts] *********************************************************
    <font color="#4E9A06">ok: [instance]</font>
    
    TASK [Include db] **************************************************************
    
    TASK [db : Show info about the env this host belongs to] ***********************
    <font color="#4E9A06">ok: [instance] =&gt; {</font>
    <font color="#4E9A06">    &quot;msg&quot;: &quot;This host is in local environment!!!&quot;</font>
    <font color="#4E9A06">}</font>
    
    TASK [db : Upgrade apt packages] ***********************************************
    <font color="#C4A000">changed: [instance]</font>
    
    TASK [db : Add key from the URL] ***********************************************
    <font color="#C4A000">changed: [instance]</font>
    
    TASK [db : Add APT repository] *************************************************
    <font color="#C4A000">changed: [instance]</font>
    
    TASK [Install mongodb package] *************************************************
    <font color="#C4A000">changed: [instance]</font>
    
    TASK [db : Configure service supervisor] ***************************************
    <font color="#C4A000">changed: [instance]</font>
    
    TASK [db : Change mongo config file] *******************************************
    <font color="#C4A000">changed: [instance]</font>
    
    RUNNING HANDLER [db : restart mongod] ******************************************
    <font color="#C4A000">changed: [instance]</font>
    
    PLAY RECAP *********************************************************************
    <font color="#C4A000">instance</font>                   : <font color="#4E9A06">ok=9   </font> <font color="#C4A000">changed=7   </font> unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
</pre>


<pre><font color="#4E9A06">molecule converge</font>
<font color="#4E9A06">iva@c8hard </font><font color="#CC0000">db (ansible-4 *=) </font><font color="#729FCF"><b>$</b></font><font color="#4E9A06"> molecule verify</font>
<font color="#4E9A06">--&gt; </font><font color="#06989A">Test matrix</font>
    
└── default
    └── verify
    
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;verify&apos;</font>
--&gt; <font color="#06989A">Executing Testinfra tests found in /home/iva/Documents/Otus/Ingvar78_infra/ansible/roles/db/molecule/default/tests/...</font>
    <b>============================= test session starts ==============================</b>
    platform linux -- Python 3.6.8, pytest-6.0.1, py-1.9.0, pluggy-0.13.1
    rootdir: /home/iva/Documents/Otus/Ingvar78_infra/ansible/roles/db/molecule/default
    plugins: testinfra-5.2.2
<b>collected 3 items                                                              </b>
    
    tests/test_default.py <font color="#4E9A06">...                                                [100%]</font>
    
    <font color="#4E9A06">============================== </font><font color="#8AE234"><b>3 passed</b></font><font color="#4E9A06"> in 3.79s ===============================</font>
<font color="#4E9A06">Verifier completed successfully.</font>
</pre>


[![Play-travis Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/play-travis?label=Play-travis&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/play-travis)

[![Cloud-bastion Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/cloud-bastion?label=Cloud-bastion&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/cloud-bastion)
[![Сloud-testapp Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/cloud-testapp?label=Сloud-testapp&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/cloud-testapp)

[![Packer-base Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/packer-base?label=Packer-base&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/packer-base)

[![Terraform-1 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/terraform-1?label=Terraform-1&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/terraform-1)
[![Terraform-2 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/terraform-2?label=Terraform-2&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/terraform-2)


[![Ansible-1 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-1?label=Ansible-1&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-1)
[![Ansible-2 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-2?label=Ansible-2&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-2)
[![Ansible-3 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-3?label=Ansible-3&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-3)
[![Ansible-4 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-4?label=Ansible-4&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-4)


[![Docker-4 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_microservices/docker-4?label=Docker-4&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_microservices/tree/docker-4)


[![Build Status](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_infra)

[![Infra Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/master?label=Ingvar78_infra&style=plastic)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_infra)


master
[![Build Status](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices)

[![Infra Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/master?label=Infra&style=plastic)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_infra)

[![Microservices Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_microservices/master?label=Microservices&style=plastic)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices)

[![Docker-2 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_microservices/docker-2?label=Docker-2&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_microservices/tree/docker-2)


docker-2

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices.svg?branch=docker-2)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices)

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices.svg?branch=docker-2)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_microservices)

[![Generic badge](https://img.shields.io/badge/Ingvar78_infra-<STATUS>-red.svg)](https://shields.io/)


<a href="https://github.com/Otus-DevOps-2020-05/Ingvar78_infra" alt="Activity">        <img src="https://img.shields.io/github/commit-activity/m/badges/shields" /></a>

[![GitHub pull-requests](https://img.shields.io/github/issues-pr/Naereen/StrapDown.js.svg)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/pull/)

<h1> Git Test  </h1>
<h2> test git ssh </h2>

https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
12

<p align="center">
    <img src="https://raw.githubusercontent.com/badges/shields/master/frontend/images/logo.svg?sanitize=true"
        height="130">
</p>

<p align="center">
    <a href="https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/graphs/contributors" alt="Contributors">
        <img src="https://img.shields.io/github/contributors/badges/shields" /></a>
    <a href="https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/badges/shields" /></a>
    <a href="https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/compare/gh-pages...master">
        <img src="https://img.shields.io/github/commits-since/badges/shields/gh-pages?label=commits%20to%20be%20deployed"
            alt="commits to be deployed"></a>
</p>
