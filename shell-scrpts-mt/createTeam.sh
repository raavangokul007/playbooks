echo "Create a team"
echo "Please enter the PAT"
read pat
curl \
  -X POST \
 -u devopstrainingblr:$pat \
  https://api.github.com/orgs/mss-octbatch2023/teams \
  -d '{"name":"facebook-devteamapi","description":"A great team","permission":"push","privacy":"closed"}'