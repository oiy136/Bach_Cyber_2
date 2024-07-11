# Syst�me
________________________________________
## Question 1
### Dans un terminal (BASH), vous tapez la commande: ps -ef | grep ssh pour:
?	Lister les fichiers de votre r�pertoire HOME?
?	Conna�tre les utilisateurs connect�s � votre session
?	`Lister les processus actifs puis filtrer la recherche   X`
?	Avoir un �tat de lieux de l�utilisation m�moire

### Quelle autre commande pourriez-vous utiliser sous Debian/Ubuntu pour avoir plus d'informations?

`Netstat �a` 

## Question 2
### Quelle commande utilisez-vous pour conna�tre l'�tat de vos interfaces r�seaux?

`ifconfig`

## Question 3
## Donnez des cas d�application des diff�rents types d�hyperviseurs.
 
Les hyperviseurs de type 1  tel que : Microsoft Hyper-V et Citrix XenServer  sont adapt� a une application en environement professionnel, pour heberger les different services de l� entreprise dans une VM allou� � un secteur car n� ayant pas besoin d� un hote ( Linux, windows .. ) il sera plus sur et plus rapide, tandis que les hyperviseurs de type 2 tel que : VMware Workstation, Oracle VirtualBox , sont plus destin� � un usage particulier pour diverse taches comme le besoin d avoir windows et linux sur le meme poste, tester un programme sur plusieur OS et bien d� autres

# R�seau
________________________________________
## Question 1
### Quels protocoles connaissez-vous? 
### Pouvez-vous les classer par types et dire lesquels repr�sentent un enjeu de s�curit�?

--Communicatiion--
IP
FTP
TCP
UDP
HTTP / HTTPS

--Securit�--
SSH

--Gestion--
ICMP
DHCP
POP3

Ils representent tous un enjeu de securit�, mais le plus expos� est le protocole de communication


## Question 2
### Sur quelle couche du mod�le OSI va travailler 
?	Un commutateur (switch)? ``Sur la couche 2 ou sur la couche 2 et 3`` 
?	Un routeur ? ``Sur la couche 3 (Couche reseau)``
?	Le protocole TCP ?  `sur la couche 4 ( Couche transport )`
?	HTTP? `Sur la couche 7 ( Couche application )`

# S�curit�
________________________________________
## Question 1
### Existe-t-il une norme pour la s�curit� informatique?
Oui la norme : ISO/IEC
## Question 2
### Concernant la s�curit�, quelles institutions/agences pouvez-vous citer pour la France? 
ANSSI, DGSE, DGSI

### A l'international? 
ENISA
OSCE
NSA

## Question  3
### Avec votre usage habituel du num�rique (PC, tablette, t�l�phone), quels sont les moments o� vous �tes vuln�rables ? 
Les moments de fatigue ou de stresse. Dans ces moments l� il est plus probable de voir sa vigilance baisser.

### Quels pourraient en �tre les cons�quences?
Installer une backdoor, un ransomeware ou autre virus


### Qui d'autre pourrait �tre impact� d'une faille de s�curit� chez vous (ou dans votre entreprise)?
Toutes les personnes en contact avec le poste infect�, la liste des personne enregistr�es en contact, comme les emails etc� tout depend du/des vecteurs accessible apres avoir compromis la machine
?
# Projet Firewall
________________________________________
## Sur un environnement Linux Debian virtualis�, vous allez configurer un firewall et le monitorer.

### Partie 1
### Sur votre machine virtuelle, installez un serveur web (apache2) et le SSH.

### Apr�s avoir v�rifi� que tout fonctionne bien, supprimer toutes les r�gles de votre firewall:
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -FF
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

### et v�rifier que la commande  iptables -nvL ne renvoi rien.

### A pr�sent, recr�ez chacune des r�gles n�cessaires pour que le serveur fonctionne (connexion ssh et serveur web).

`Fichier exo.sh`

## Partie 2
### Afin d�enregistrer et de surveiller l�activit� du serveur, installez le paquet logwatch.
### Configurez-le afin que soient enregistr�es toutes les tentatives de connexion (par 24h) dans un fichier.

Une fois logwatch install� je vais editer le fichier /etc/logwatch/conf/logwatch.conf

je modifie les arguments suivants : 
Output = file # Choisir d ecrire les logs dans un fichier
Filename = /tmp/logwatch # Choix de l emplacement du fichier contenant les logs
Detail = High # Mettre le verbose au maximum

Pour que les logs soient enregistr�e toute les 24h nous devons ajouter une tache chronologique avec la commande suivante :

sudo crontab �e

Il ne reste plus qu' a mettre cette ligne et de sauvegarder.

0 0 * * * logwatch








## Partie 3
### A l�aide de Fail2ban, traiter les logs enregistr�s afin que: 
?	Plus de 5 tentatives �chou�es de connexions � un compte user (ftp ou ssh) 
Dans la partie [Default] je change les parametres suivant : 
bantime  = 15m
maxretry = 5

?	Plus de 10 requ�tes via la m�me IP � destination du serveur FTP
On cr�e une nouvelle partie [FTP-dix] les parametres suivant : 

enabled = true
port = ftp
maxretry = 10
findtime = 15m
bantime = 25m

?	Plus de 20 demandes de connexion au serveur FTP m�me d�utilisateurs diff�rents en 5 minutes
soit interpr�t� comme un signe de TBF (Tentative de Brute Force).

Dans la partie [FTP-vingt] je change les parametres suivant : 

enabled = True
bantime  = 55m
findtime  = 5m
maxtry = 20