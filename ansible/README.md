# Recettes ansible :
* pour créer un serveur web avec apache2 et PHP, lancer la recette apache2test.yml

## Aide mémoire ansible :
* `ansible -i <targethost>, -m setup all` pour attaquer la machine *targethost* (ip ou nom)
* `ansible -i <hostfile> -m setup all` pour cible le fichhier *hostfile*
* `ansible-playbook -i <targethost>, -b -K apache2test.yml` pour :
  * lancer le script *apache2test.yml*
  * en changeant de user (*-b* = become, par défaut *root*)
  * en demandant le mot de passe (*-K*)
  
  
  
