#!/bin/bash


function exit_exception () {

	# This if-statement won't work
	#if [ $? -eq 130 ]; then
        #	echo "Exiting..."
	#fi

	echo "Exiting..."
	exit 1

}

function switch_branch () {

	 trap exit_exception SIGINT


	select=$(git branch | fzf \
		--height 40% \
		--layout reverse \
		--border\
		--preview 'git log --oneline $(echo {} | tr -d "* ")' \
		--color bg:#776644,preview-bg:#446655)

	select=$(echo "$select" | tr -d "* ")

	git switch "$select"

}

function merge_branch (){

	trap exit_exception SIGINT

	select=$(git branch | fzf +m \
		--height 100% \
		--layout reverse \
		--border\
		--preview 'git log --oneline $(echo {} | tr -d "* ")' \
		--color bg:#776644,preview-bg:#446655)

	select=$(echo "$select" | tr -d "* ")

	git merge "$select"
}

function delete_branch () {
	
	trap exit_exception SIGINT

	select=$(git branch | fzf +m \
		--height 40% \
		--layout reverse \
		--border\
		--preview 'git log --oneline $(echo {} | tr -d "* ")' \
		--color bg:#776644,preview-bg:#446655)

	select=$(echo "$select" | tr -d "* ")

	git branch -d "$select"
}

function main () {

	trap exit_ecception SIGINT

	opt_menu=("1 - Switch branch"\
		  "2 - Merge"\
		  "3 - Delete branch"\
		  "Exit")

	sel_menu=$(for opt in "${opt_menu[@]}"; do echo "$opt"; done | fzf +m \
			--height 40% \
			--layout reverse \
			--border\
			--color bg:#776644\
		)


	case "$sel_menu" in ${opt_menu[0]})
		echo "$sel_menu"
		switch_branch
		exit 0
		;;

  	      ${opt_menu[1]})
		echo "$sel_menu"
		merge_branch
		exit 0
		;;
	      ${opt_menu[2]})
		echo "$sel_menu"
		delete_branch
		exit 0
		;;
	     *)
	     	echo "$sel_menu"
	     	exit 0
	
	esac
}

main

