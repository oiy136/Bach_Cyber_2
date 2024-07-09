#Bash

# Regles existantes
echo -e "Listes des regles iptables presentes\n\n"
sudo iptables -nvL

# Effacement de toutes les regles iptables

echo -e '\nOn efface\n\n'
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -nvL
# Ouvrir les ports http/s 80 et 443, SSH 22 et FTP 21

echo -e '\nOn ecrit les nouvelles regles\n\n'
sudo iptables -A INPUT -p tcp --dport 21 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Affichage des regles

echo -e "\nNouvelles regles\n\n"

sudo iptables -nvL