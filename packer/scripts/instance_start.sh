rm -rf profile_website_backend
git clone https://github.com/zzawook/profile_website_backend.git

./profile_website_backend/run_application.sh
docker compose -f ./profile_website_backend/jenkins/compose.yaml up -d --build