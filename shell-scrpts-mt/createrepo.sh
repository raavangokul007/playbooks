echo "Creating the repo..."
echo "Please enter the PAT"
read token

curl \
  -X POST \
  -u devopstrainingblr:$token \
  https://api.github.com/orgs/mss-octbatch2023/repos \
  -d '{"name":"FacebbokAPITest","private":false,"description":"This is your first repo by github api"}'
  