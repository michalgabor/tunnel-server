FROM alpine:latest

LABEL maintainer "https://github.com/michalgabor/tunnel-server"

ENV ROOT_PASSWORD root

RUN apk --update add openssh \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& sed -i s/#GatewayPorts.*/GatewayPorts\ yes/ /etc/ssh/sshd_config \
		&& echo "root:${ROOT_PASSWORD}" | chpasswd \
		&& rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
