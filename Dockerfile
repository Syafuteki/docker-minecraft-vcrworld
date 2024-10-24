#OSのインストール
FROM ubuntu:22.04

#パッケージ管理ツールのアップデート
RUN apt update && apt --yes upgrade

#使わないけど入れておいたパッケージ
RUN apt install -y vim
RUN apt install -y screen

#Javaのダウンロード
RUN apt install -y wget openjdk-21-jdk-headless

#minecraftサーバ用のフォルダ作成
RUN mkdir /srv/minecraft/
WORKDIR /srv/minecraft/

#サーバファイルのインストール
RUN wget -O server.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.3.0/forge-1.20.1-47.3.0-installer.jar
RUN java -Xmx3072M -Xms3072M -jar server.jar --installServer

#サーバ実行のための準備
RUN echo eula=true > eula.txt

#VCRワールドの導入
RUN mkdir ./world/
WORKDIR /srv/minecraft/world/
RUN wget -O VCR.zip https://t.co/EGKyfMehhS
RUN apt install -y unar
RUN unar VCR.zip
RUN rm VCR.zip
WORKDIR /srv/minecraft/world/VCR_minecraft_ƒÀ/
RUN mv * /srv/minecraft/world/
WORKDIR /srv/minecraft/world/
RUN rm -rf VCR_minecraft_ƒÀ

#VCRワールドで使用されているサーバ側MODの導入
WORKDIR /srv/minecraft/
RUN mkdir ./mods/
WORKDIR /srv/minecraft/mods/
RUN wget -O voicechat-forge-1.20.1-2.5.24.jar https://mediafilez.forgecdn.net/files/5794/966/voicechat-forge-1.20.1-2.5.24.jar
RUN wget -O Mine_and_Slash-1.20.1-5.8.3.jar https://mediafilez.forgecdn.net/files/5822/5/Mine_and_Slash-1.20.1-5.8.3.jar
RUN wget -O curios-forge-5.10.0+1.20.1.jar https://mediafilez.forgecdn.net/files/5680/164/curios-forge-5.10.0%2B1.20.1.jar
RUN wget -O player-animation-lib-forge-1.0.2-rc1+1.20.jar https://mediafilez.forgecdn.net/files/4587/214/player-animation-lib-forge-1.0.2-rc1%2B1.20.jar
RUN wget -O Library_of_Exile-1.20.1-1.5.3.jar https://mediafilez.forgecdn.net/files/5810/796/Library_of_Exile-1.20.1-1.5.3.jar

#サーバ実行
WORKDIR /srv/minecraft/
RUN ["/bin/sh", "-c", "chmod 777 run.sh"]
CMD ["/bin/sh", "-c", "./run.sh"]
