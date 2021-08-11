docker rm test-upload

docker run \
--env-file .env \
--workdir /github/workspace \
-v `pwd`:/github/workspace \
--name test-upload az-blob-storage-upload