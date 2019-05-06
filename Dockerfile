FROM gcr.io/kaggle-images/python

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y emacs zsh 
RUN pip install --upgrade pip
RUN pip install --upgrade pandas matplotlib patsy torch
RUN pip install arviz autopep8 jupyterlab
RUN conda update -n base conda
RUN conda install -y nodejs
RUN conda install -y jupyterlab jupyter
RUN apt-get install -y nodejs

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication /PasswordAuthentication /' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

