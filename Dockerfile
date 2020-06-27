FROM ubuntu:latest
RUN mkdir -p /var/run/sshd
RUN apt-get -y update 
RUN apt-get install openssh-server -y   
RUN  apt-get install openssh-clients  -y 
RUN echo 'root:abc@123' | chpasswd
RUN ssh-keygen -A 
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIVLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN apt-get install curl -y 
RUN curl -LO https://storage.googleapis.com/kubernates-resealse/release/`curl  -s https://storage.googlepis.com/kubernates-release/release/stable.txt`/bin/linux/amd64/kubectl 
RUN mv ./kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl
RUN mkdir /root/.kube
COPY client.key /root/
COPY client.crt /root/
COPY ca.crt  /root/
COPY config /root/.kube/
ADD ./sshd_config /etc/ssh/sshd_config
CMD ["/usr/sbin/sshd","-D"]
EXPOSE 22

