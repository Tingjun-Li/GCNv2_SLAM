# To build docker
`docker build --tag tingjunl/pytorch_1.0.1_gcnv2_slam .`

# First time to start docker
`bash run_build_docker.bash gcnv2_slam`

# Second time to start docker
`docker start gcnv2_slam`

# Execute docker (access the docker environment)
`docker exec -it gcnv2_slam /bin/bash
or
`docker exec -u root -it gcnv2_slam /bin/bash

Then you may download the repo inside the docker, build it, and run it.
