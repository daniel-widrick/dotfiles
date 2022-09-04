
if [ "$myPRofileLoaded" != "1" ]
then

	export GOPATH=$HOME/go
	export PATH=$PATH:$GOPATH/bin:$HOME/bin
	export PATH=$PATH:/opt/work/jetbrains-toolbox/
	alias rider=rider.sh
	alias dotnet=/opt/work/dotnet/dotnet
	alias datagrip=datagrip.sh
	alias goland=goland.sh
	alias vim=nvim
fi
myProfileLoaded="1"
. "$HOME/.cargo/env"
