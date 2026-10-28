#!/bin/bash


function switch_branch () {
	select=$(git branch | fzf \
		--height 40% \
		--layout reverse \
		--border\
		--preview 'git log --oneline $(echo {} | tr -d "* ")' \
		--color bg:#776644,preview-bg:#446655)

	 # This if-statement won't work
        if [ $? -eq 130 ]; then
                echo "Exiting..."
        fi



	select=$(echo "$select" | tr -d "* ")



	git switch "$select"

}

switch_branch
