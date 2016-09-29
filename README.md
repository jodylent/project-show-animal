# project-show-animal
If servers are cattle, not pets, what are workstations? They are "show animals"--valuable, pampered compared to cattle, but in the end, only kept as long as they are useful, and easily replaced with the day comes.

We want our Macs to be tools--fungible, flexible and easily rebuilt--and this is a project to make it possible to rebuild a Mac every week.

## Directions:

Clone this repo:

	git clone https://github.com/jodylent/project-show-animal.git

Modify input_vars.sh (set your Git user info + token)

	sed -i -e "s/^GIT_NAME=.*/GIT_NAME=Your Name/g" ${SCRIPTDIR}/input_vars.sh
	sed -i -e "s/^GIT_EMAIL=.*/GIT_EMAIL=you@email.com/g" ${SCRIPTDIR}/input_vars.sh
	sed -i -e "s/^GITHUB_USER=.*/GITHUB_USER=yourusername/g" ${SCRIPTDIR}/input_vars.sh
	sed -i -e "s/^GITHUB_TOKEN=.*/GITHUB_TOKEN=HexStrWeDeleteWhenDone/g" ${SCRIPTDIR}/input_vars.sh

Run new_mac.sh

	bash /path/to/project-show-animal/new_mac.sh


