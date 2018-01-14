LEPAGE Tim
SERGEANT Dimitri
		
			Projet APF RICM3 Groupe 2 2016

***Principe du Projet***

Le but de ce projet est d’écrire un programme Ocaml capable de lire et d’interpréter un système de Lindenmayer (aussi appelé L-système), qui permet entre autres de modéliser la croissance de végétaux. Le concept central des L-Systèmes est la représentation d’une plante par une chaîne de caractères. Cela permet de modéliser son évolution, voire sa destruction par des agents pathogènes, au moyen de règles de transformations de ces caractères.

***Ce qui fonctionne***

Module Tortue
La gestion des ramifications
Croissance des plantes
Generation aleatoire (Possibilités de boucles)
Application de regles
La mutation

***Ce qui ne fonctionne pas***

Affichage en sortie SVG
Possibilité d'entrer sa propre règle depuis le terminal

***Aide Exterieure***

-Monsieur Michaël Périn pour la syntaxe de l'alphabet pour coder les figures. Il nous a conseillé sur la manière d'intégrer les crochets au type motif et ainsi éviter les séquences non conformes.
-Un autre étudiant pour la partie svg qui ne fonctionne toujours pas même après son aide et multiple essais, nous l'avons donc mis en commentaire et supprimé aux endroits ou elle était censé être utilisée. 

***Utilisation***
-Se placer dans le repertoire <nomdurepertoire>
-Executer la commande make
-Executer <nomdesexecutables>

***Les executables***
-dessinkoch : réalise les flocons de koch: applique une règle n fois avec un n choisit par l'utilisateur.
-dessinramif: réalise les ramifications données en exemple : applique la règle qui à F associe F[PF]F[MF]F n fois avec un n choisit par l'utilisateur
-dessinmut  : réalise les mutations sur la base de ramification avec une probabilité p entrée par l'utilisateur
-dessinauto : génère une règle aléatoire et applique cette même règle n fois.  (ne fonctionne pas toujours car notre fonction de génération d'une règle juste n'est pas opérationnelle et boucle la plupart du temps.
-dessinuser : réalise le dessin dont les paramètres (motifs, règle, nombre de fois que l'on va appliquer la règle) sont demandés à l'utilisateur.


