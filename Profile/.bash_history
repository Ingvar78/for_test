sudo su
sudo apt install mc
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER | sudo ls -la /etc/sudoers.d/
sudo apt-get install pacman4console
pacman4console
sudo shutdown now
