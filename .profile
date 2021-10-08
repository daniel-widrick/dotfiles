
if [ "$myPRofileLoaded" != "1" ]
then

	export PATH=$PATH:/opt/work/rider/bin:/opt/work/dotnet:/opt/work/datagrip/bin
	alias rider=rider.sh
	alias dotnet=/opt/work/dotnet/dotnet
	alias datagrip=datagrip.sh
fi
myProfileLoaded="1"
