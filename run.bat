if not exist %USERPROFILE%/.gitconfig (
	type nul > %USERPROFILE%/.gitconfig
)

git submodule update --init --recursive
git submodule update --recursive --remote

docker compose up -d apt-cache
docker compose up -d linux-dev-desktop --build
