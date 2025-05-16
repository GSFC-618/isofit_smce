# Build a lightweight version of isofit to run on the SMCE
Helper code to build a lightweight version of the ISOFIT code (without the data embedded in the container) to run on the SMCE

<br>

More extensive documentation can be found on the wiki pages: https://github.com/GSFC-618/isofit_smce/wiki

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

<b>NOTE: Improved documentation to come<b>
