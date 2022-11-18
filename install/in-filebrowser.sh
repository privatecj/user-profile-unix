# Install QBittorrent

mkdir /tmp/torrent
pushd /tmp/torrent


sudo rm -rf /home/cj/appdata/qbittorrent/config
sudo rm -rf /home/cj/appdata/qbittorrent/torrents
sudo rm -rf /home/cj/torrents

mkdir -p /home/cj/appdata/qbittorrent/config
mkdir -p /home/cj/appdata/qbittorrent/torrents
mkdir -p /home/cj/torrents

git clone https://github.com/mypracticeapps/qbittorrent.git

cd qbittorrent

docker build -t qbittorrent .

docker run -d --user $UID:$GID \
  --name=qbittorrent \
  --restart unless-stopped \
	-p 8000:8080 -p 6881:6881/tcp -p 6881:6881/udp \
	-v /home/cj/appdata/qbittorrent/config:/config \
	-v /home/cj/appdata/qbittorrent/torrents:/torrents \
	-v /home/cj/torrents:/downloads \
	qbittorrent

cd ..
rm -rf qbittorrent

popd


# Install file browser
mkdir -p /home/cj/appdata/filebrowser
touch /home/cj/appdata/filebrowser/filebrowser.db

docker run -d \
    --name=APP-FILE_BROWSER \
    --restart unless-stopped \
    -v /home/cj/torrents:/srv \
    -v /home/cj/appdata/filebrowser/filebrowser.db:/database.db \
    -u $(id -u):$(id -g) \
    -p 8001:80 \
    filebrowser/filebrowser