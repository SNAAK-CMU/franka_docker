# iam-docker

## [Docker Installation Instructions](https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository):
1. Install Prerequisites:
```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg build-essential
```
2. Setup Keyrings
```
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
3. Update
```
sudo apt-get update
```
4. Install Docker
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
5. Check if Docker was installed properly.
```
sudo docker run hello-world
```
6. Add yourself to the docker group.
```
sudo usermod -aG docker $USER
```
7. Reboot the computer and check that you can run the following command without any errors.
```
docker run hello-world
```
