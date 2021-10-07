
if [ "$myPRofileLoaded" != "1" ]
then

	export PATH=$PATH:/opt/work/rider/bin:/opt/work/dotnet
	alias rider=rider.sh
	alias dotnet=/opt/work/dotnet/dotnet
fi
myProfileLoaded="1"
