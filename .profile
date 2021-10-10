
if [ "$myPRofileLoaded" != "1" ]
then

	export GOPATH=$HOME/go
	export PATH=$PATH:/opt/work/rider/bin:/opt/work/dotnet:/opt/work/datagrip/bin:/opt/work/webstorm/bin:/opt/work/goland/bin:$GOPATH/bin
	alias rider=rider.sh
	alias dotnet=/opt/work/dotnet/dotnet
	alias datagrip=datagrip.sh
	alias goland=goland.sh
fi
myProfileLoaded="1"
