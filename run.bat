if not exist %USERPROFILE%/.gitconfig (
	type nul > %USERPROFILE%/.gitconfig
)
docker compose up -d apt-cache
docker compose up -d linux-dev-desktop --build
