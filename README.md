## Quelques scripts et autres fichiers ##
Dans le cas général, quelques infos sont précisées en début de script pour décrire de quoi il retourne...
* done.txt : les commandes lancées sur un Raspbian Stretch pour aboutir à l'installation de NextCloud.
* forcespin.sh : change les paramètres du disque dur sur utilisé pour stocker le système pour éviter qu'il se mette en veille (la sortie de veille peut geler le Raspberry... En tous cas j'ai constaté un problème, je tente ça pour voir...)
* nextcloud-WSDocker.sh :
    * installe docker depuis le site de docker (version plus à jour que celle des dépôts)
    * récupère les scripts de Build et run de mes containers
    * récupère nextcloud depuis le site de nextcloud et fait l'installation
* nextcloud-WSHost.sh : 
    * installe un serveur apache avec les modules qui vont bien pour faire tourner nextcloud
    * **Attention : s'appuie sur php7, donc plutôt debian stretch...**
    * récupère nextcloud depuis le site de nextcloud et fait l'installation
* Mediapart.sh : 
    * fait un epub à partir des articles sur le site de Mediapart (requiert un compte et calibre)
    * l'envoie par mail, en fait une copie locale et distante (hubic)
    * nécessite dans le répertoire le fichier Mediapart.recipe et Mediapart.sh.env avec le compte sur mediapart.fr
