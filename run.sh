mkdir -p /etc/mosquito
setenforce 0
docker run -d -p 80:80  -v /etc/mosquito:/application/rbac -v /upload:/upload --env-file ./.envfile --name mosquito liaomin789/mosquito:1.0.1
