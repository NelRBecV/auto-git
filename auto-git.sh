#!/bin/bash


select=$(git branch | fzf \
	--height 40% \
	--layout reverse \
	--border\
	--preview 'git log --oneline $(echo {} | tr -d "* ")' \
	--color bg:#776644,preview-bg:#446655)
	

select=$(echo "$select" | tr -d "* ")



git switch "$select"

