# Build a lightweight version of isofit to run on the SMCE
Helper code to build a lightweight version of the ISOFIT code (without the data embedded in the container) to run on the SMCE

<br>

!!! NOTE!!! Documentation needs updating - coming soon


<br>

### To update the version of ISOFIT submodule you can run:

<br>

```

git submodule update --init --recursive

git submodule update --remote --merge
```

### To build the images locally, run

Clone the repo and cd into the directory
```
cd isofit_smce
```

then run

```
bash scripts/build_isofit.sh
```

This will build the image without the embedded ISOFT examples and data. After the image is built, it will be pushed to the Docker Hub location: <br>
https://hub.docker.com/repository/docker/serbinsh/isofit_smce/general

You can run ```docker images``` or ```docker image ls``` to see the newly built image
e.g. <br>

![Screenshot 2025-05-01 at 9 34 21 AM](https://github.com/user-attachments/assets/7e5f5685-c225-4eec-b4ba-e12854b17f5b)

<br>

### To test the build you can run the following steps:

1) ```docker run --rm -it serbinsh/isofit_smce:multiarch_v3.4.1 bash```
This will confirm you can enter the image at the Bash command line. At this stage you should only see the ISOFIT code directory in home

<br>

![Screenshot 2025-05-01 at 9 36 07 AM](https://github.com/user-attachments/assets/53f63fb2-371d-41d3-b54f-3431227edb3c)

You will also see the stub for where we will map in the external ISOFT examples and data within the container, located at /isofit_data
<br>
![Screenshot 2025-05-01 at 9 36 59 AM](https://github.com/user-attachments/assets/05c05ee3-fe18-499e-bbcd-c7022f401ec2)

2) You can confirm the isofit library is functionl and check the version by running <br>
```docker run --rm -it serbinsh/isofit_smce:multiarch_v3.4.1 isofit --version```

<br>
 
![Screenshot 2025-05-01 at 9 37 43 AM](https://github.com/user-attachments/assets/66bae264-f944-4cc9-9236-37866ac008de)

3) Next you can initialize or check the status of the external ISOFIT data and examples by running

```
docker run --rm -it -v ~/Data/isofit_home:/home/mambauser/.isofit \
-v ~/Data/isofit_data_docker:/isofit_data serbinsh/isofit_smce:multiarch_v3.4.1 \
isofit -b /isofit_data download all
```

In this example, we are using the local host directories:
```
~/Data/isofit_home
~/Data/isofit_data_docker
```
to map into the empty stub directories within the container

~/Data/isofit_home - to contain the ISOFIT ini configuration file that tells ISOFIT where to find the data
~/Data/isofit_data_docker - contains the data

4) You can then build or check the build of the ISOFIT data and tutorials

```
docker run --rm -it -v ~/Data/isofit_home:/home/mambauser/.isofit \
-v ~/Data/isofit_data_docker:/isofit_data serbinsh/isofit_smce:multiarch_v3.4.1 \
isofit build
```

5) Now that you have downloaded the data and built the examples, you can run one of the example scripts, e.g.

```
docker run --rm -it --shm-size=16gb -v ~/Data/isofit_home:/home/mambauser/.isofit \
-v ~/Data/isofit_data_docker:/isofit_data serbinsh/isofit_smce:multiarch_v3.4.1 \
bash /isofit_data/examples/20151026_SantaMonica/run.sh
```
  

6) The new ISOFIT image and data are now ready to run more examples or run new processing workflows!

You can also explore additional examples and customizations using the ISOFIT documentation
https://isofit.readthedocs.io/en/latest/custom/docker.html#getting-started

e.g. 
To use the provided JupyterHub deployment, you can follow the provided instructions by including your newly created directories on your local host, 

```
docker run --rm --shm-size=16gb -p 8888:8888 -v ~/Data/isofit_home:/home/mambauser/.isofit \
-v ~/Data/isofit_data_docker:/isofit_data serbinsh/isofit_smce:multiarch_v3.4.1
```

After this runs, you can enter into the running container using your browser and navigating to 
[https://127.0.0.1:8888](http://127.0.0.1:8888/lab)


<b>NOTE: Improved documentation to come<b>
