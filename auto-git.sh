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


merge_branch
