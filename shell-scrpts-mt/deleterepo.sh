echo "Deleting repo"
echo "Please enter the PAT"
read pat
curl \
  -X DELETE \
  -u devopstrainingblr:$pat \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/mss-octbatch2023/FacebbokAPITest