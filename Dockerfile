#FROM ubuntu:22.04
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04
SHELL ["/bin/bash", "-c"]

# Timezone, Launguage設定
RUN apt update \
  && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
     locales \
     software-properties-common tzdata \
  && locale-gen ja_JP ja_JP.UTF-8  \
  && update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 \
  && add-apt-repository universe

# Locale
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

#package install
RUN apt update && apt upgrade -y\
    && DEBIAN_FRONTEND=noninteractive apt install -y curl vim git wget htop \
    python3.10-dev python-is-python3 python3-pip \
    gnupg gnupg2 lsb-release nano 

#ROS2 install
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg &&\
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null &&\
    apt update && apt upgrade -y && apt install -y ros-humble-desktop
    
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y\
    python3-colcon-common-extensions python3-rosdep &&\
    source /opt/ros/humble/setup.bash &&\
    rosdep init

#userをグループに追加
ARG UID
ARG GID
ARG USER_NAME
ARG GROUP_NAME

#sudo パスワードを無効化
RUN groupadd -g ${GID} ${GROUP_NAME} && \
        useradd -m -s /bin/bash -u ${UID} -g ${GID} -G sudo ${USER_NAME} && \
        echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/${USER_NAME}

#ユーザーをrootからユーザーに変更
USER $USER_NAME

#PS1
RUN echo "PS1='\[\033[44;37m\]Docker\[\033[0m\]@\[\033[32m\]\u\[\033[0m\]:\[\033[1;33m\]\w\[\033[0m\]\$ '" >> /home/${USER_NAME}/.bashrc

#ROS2 workspace作成
RUN mkdir -p catkin_ws/src
COPY tb3_vision /home/${USER_NAME}/catkin_ws/src/tb3_vision
RUN cd catkin_ws &&\
    rosdep update &&\
    rosdep install -y -i --rosdistro humble --from-paths src &&\
    colcon build && echo "source ~/catkin_ws/install/setup.bash" >> /home/${USER_NAME}/.bashrc

#tempに実行ファイル追加
COPY assets/setup.sh /tmp/setup.sh
COPY assets/nanorc /home/${USER_NAME}/.nanorc
RUN sudo chmod +x /tmp/setup.sh ;\
    sudo chmod -R 777 /home/${USER_NAME}/catkin_ws ;\
    echo "source /opt/ros/humble/setup.bash" >> /home/${USER_NAME}/.bashrc ;\
    echo 'export ROS_DOMAIN_ID=7' >> /home/${USER_NAME}/.bashrc 
WORKDIR /home/${USER_NAME}/catkin_ws
ENTRYPOINT ["/tmp/setup.sh"]
#setup.shで毎回source /opt/ros/humble/setup.bashしている
