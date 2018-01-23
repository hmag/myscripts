#!/bin/bash
# ajout de lignes dans le fichier ~/.bashrc pour utiliser les fichiers de bash completion dans
# un répertoire particulier :
#  for bcfile in ~/.bash_completion.d/* ; do
#          . $bcfile
#  done
# et pour ce script, ajout d'un fichier avec ça dedans :
# _bashcompl()
# {
#   _script_commands=$(/home/johe/bin/bashcoompl list)
# 
#   local cur
#   COMPREPLY=()
#   cur="${COMP_WORDS[COMP_CWORD]}"
#   COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )
# 
#   return 0
# }
# complete -o nospace -F _bashcompl ./bashcompl.sh

listargs="option1 option2 option3 option4"
contains() {
   [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && return 0 || return 1
   }
if [ $# -ne 1 ]; then
       echo "Syntaxe : $0 <destination>"
       echo "Saisie de la destination manuellement..."
       echo "Backup vers : $listargs"
       echo "Votre choix ? "
       read reponse
       echo "Réponse fournie : $reponse"
else
       if [ $1 = "list" ]; then
               echo $listargs
               exit 0
       else
               reponse=$1
       fi
fi
contains "$listargs" "$reponse"
if [ $? -eq 0 ]; then
       echo "présent dans la liste"
       dest=$reponse
else
       echo "non présent dans la liste"
       exit 1
fi
echo "Destination : $dest"
