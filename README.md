******************Архив project-sb.zip**********************************************************************

Архив project-sb.zip содержит структуру размещения файлов и директорий, аналогичную GIT-репозиторию со скриптами и deb-пакетами на
веб-ресурсе GitHub:
Каталог packages содержит собранные deb-пакеты для развертывания сервисов на виртуальных машинах + вспомогательные пакеты
Каталог source содержит подкаталоги с ресурсами для сборки deb-пакетов (скрипты, конфиги и т.п.)
Подробнее процесс развертывания всех виртуальных машин проекта описан в документе Admin_Guide.docx
**********************
/packages/:   
1. deploy-ca_0.1-1_all.deb    пакет для развертывания СА-сервера (vm-ca-srv). Содержит скрипты, зависимости и конфигурационный файл для easy-rsa
2. deploy-mon_0.1-1_all.deb   пакет для развертывания сервера для мониторинга (vm-mon-srv). Содержит скрипты, зависимости и конфиг файлы для nginx и Prometheus
3. deploy-ovpn_0.1-1_all.deb  пакет для развертывания OpenVPN сервера (vm-ovpn-srv). Содержит скрипты, зависимости и конфиг файлы для OpenVPN и Prometheus экспортеров 
4. deploy-pckg_0.1-1_all.deb  пакет для развертывания сервера с репозиторием для deb-пакетов (vm-pckg-srv). Содержит скрипты, зависимости и конфиг файлы для nginx и     Prometheus экспортеров
5. deb-ssh-tmp_0.1-1_all.deb  вспомогательный пакет для доставки временной конфигурации ssh-сервера. Это нужно для возможности добавления публичных ключей с других серверов для дальнейшего обмена файлами по ssh. Пакет используется на серверах vm-pckg-srv и vm-opvn-srv
6. ovpn-exporter_0.1-1_all.deb вспомогательный пакет для установки службы openvpn-exporter (бинарник был собран из исходников). Используется на OpenVPN сервере
7. synch-git_0.1-1_all.deb - вспомогательный пакет для установки сл7ужбы synch-git. Запускает по расписанию синхронизацию с удаленным репозитарием git Используется на vm-pckg-srv.


**********************
/source/:
1. ca - директория для сборки пакета deploy-ca
2. mon - директория для сборки пакета deploy-mon
3. ovpn - директория для сборки пакета deploy-ovpn
4. ovpn-exp - директория для сборки пакета ovpn-exporter
5. pckg - директория для сборки пакета deploy-pckg
6. ssh - директория для сборки пакета deb-ssh-tmp
7. synch-git - директория для сборки пакета synch-git
***********************
Сборка пакетов осуществляется на сервере vm-pckg-srv, соответственно скрипты для сборки находятся внутри директории для сборки пакета deploy-pckg, т.е. pckg (после инсталляции пакета deploy-pckg эти скрипты также присутствуют в /usr/bin/). Перечень скриптов для сборки пакетов:
source/pckg/make_pckg_ca.sh	    Создает deb-пакет deploy-ca для развертывания сервера УЦ 
source/pckg/make_pckg_mon.sh	Создает deb-пакет deploy-mon для развертывания сервера мониторинга
source/pckg/make_pckg_pckg.sh	Создает deb-пакет deploy-pckg для развертывания этого сервера 
source/pckg/make_pckg_ovpn.sh	Создает deb-пакет deploy-ovpn для развертывания сервера OpenVPN 
source/pckg/make_pckg_ssh.sh	Создает deb-пакет deb-ssh-tmp для создания временной конфигурации ssh-сервера
source/pckg/make_pckg_exp_ovpn.sh  Создает deb-пакет ovpn-exporter для установки службы openvpn-exporter 
source/pckg/make_pckg_git.sh	Создает deb-пакет synch-git

************************
Также в каждом подкаталоге внутри source находятся файлы для сборки deb-пакетов (если они задействованы):
control
preinst
postinst
prerm
postrm
************************
и конфигурационные файлы для различных служб, например nginx или Prometheus
************************
Плюс в каждом из подкаталогов внутри source находятся скрипты, которые также входят в состав пакета при сборке. При инсталляции они копируются в /usr/bin/ и используются как при начальной настройке, так и в процессе работы служб виртуальной машины. Краткая аннотация о назначении каждого скрипта находится сразу под "шебангом".
************************
В подкаталоге source/ovpn присутствуют 2 подкаталога: 
ClientWin
ClientLinux
В них находятся скрипты и конфигурационные файлы соответственно для клиентов OVPN на Windows и Linux машинах (Подробнее в документе VPN_Users_Guide.docx)
*********************************************************************************

***************Архив DOCS.zip ***************************************************
Содержит Документацию
1. Admin_Guide.docx  - Руководство Администратора по развертыванию инфраструктуры "с нуля"
2. BCG.doc - Руководство по обеспечению непрерывности бизнеса (бэкап и восстановление, сценарии, ...)
3. Modern_Plan.docs - План по модернизации
4. Monitoring_Plan.docx - проект мониторинга
5. VPN_Users_Guide.docx - Руководство пользователя по подключению VPN
6. Common_Scheme.pdf - Общая схема
7. DataFlowsScheme.pdf - Схема потоков данных
*****************************************************************************

************** Архив ScreenShots.zip ****************************************
1. CA_Created.jpg - скриншот созданного корневого сертификата
2. Fired_alert1.jpg, Fired_alert2.jpg, Fired_alert3.jpg - полученные по почте FiredAlerts от AlertManager
3. OVPN_connect_Linux.jpg - соединение OpenVPN из Linux машины
4. OVPN_connect_Win.jpg - соединение OpenVPN из Windows машины
5. PROM_Alerts.jpg - веб страница алертов Prometheus сервера
6. PROM_targets.jpg - веб страница таргетов Prometheus сервера
7. Snapshots.jpg - снэпшоты Google Cloud, созданные в автоматическом и ручном режиме



