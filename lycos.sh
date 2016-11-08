#!/bin/bash
#
promptyn () {
    while true; do
        read -p "$1 " yn
        case $yn in
            [Yyo]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

PS3='Entrer votre choix: '
options=("Chercher les fichiers contenant le texte" "Chercher par nom de fichier" "Chercher un fichier par taille" "Quitter")
select opt in "${options[@]}"
do
    case $opt in
        "Chercher les fichiers contenant le texte")
            read -p "Quel texte souhaitez vous chercher : " text
            if promptyn "Voulez vous limiter la recherche à une extension de fichier ? (o/n) : "; then
                read -p "Quelle est cette extension (exemple : *.php) : " limit
            else
                limit='*'
            fi
            echo ""
            echo "Recherche du texte : '$text' pour l'extension '$limit'"
            echo ""
            grep -rnw '.' -ie "$text" --include $limit
            break;
            ;;
        "Chercher par nom de fichier")
            read -p "Quel est le nom de fichier que vous recherchez (exemples Test.txt, *.php) : " text
            echo ""
            echo "Recherche des fichiers ayant le nom : '$text'"
            echo ""
            find . -type f -name $text
            break;
            ;;
        "Chercher un fichier par taille")
            read -p "Quelle est votre sélecteur de taille ? (+, -, =) " select
            read -p "Quelle est la taille recherchée ? (100k, 1M, 10G) " size

            echo ""
            echo "Recherche des fichiers ayant la taille : '$select$size'"
            echo ""
            find . -type f -size $select$size -exec ls -h {} \;
            break;
            ;;
        "Quitter")
            break
            ;;
        *) echo invalid option;;
    esac
done
