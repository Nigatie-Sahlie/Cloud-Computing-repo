# Multi-Stage image Build 

Multi-stage bulid is use multiple `FROM Stages` in one Dockerfile. The main purpose is to build application in one stage, then copy only the necessary files into a smaller final image.

## Files 
- **go.mod:**
- **Dockerfile.naive:** Build and run the application in the same environment. 
- **Dockerfile:** Build the application, throw away the build environment, and ship only what is needed(/out/server) to run it.
- **main.go:** The main go application.

#### `NOTE`: this specific project shows how the multi-stage image build reduce the size of images by separeting the building stage and run stage. 
