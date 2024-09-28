# README

This details the steps for getting Docker setup to run the New Media Caucus website.

## Step 0: Go Install Docker Engine and Docker Compose.
Before we can start, you will have to install the Docker Engine on your computer. You can follow the official documentation, which you can find here for your OS:

Linux: https://docs.docker.com/engine/install/

macOS: https://docs.docker.com/desktop/install/mac-install/

Windows: https://docs.docker.com/desktop/install/windows-install/

You will also have to install Docker Compose via https://docs.docker.com/compose/install/, because it greatly facilitates running multiple containers with different services, and we will of course have examples of using Docker Compose in this recipe.

## Step 1: Submodule the New Media Caucus website repo.
Submodule lets you keep a git repo inside another git repo! Super cool!

Note!: In the command below I have a placeholder token called your_github_token_goes_here. 

You must change your_github_token_goes_here with your very own personal GitHub token.

Don’t have a GitHub token? You can create one for your account at https://github.com/settings/tokens. When you are creating a token, you only need to check the first checkbox:  repo to enable Full control of private repositories.

I do myself a favor and give myself a generous expiration date of about 6 months. You do you.

OK. Here's the submodule command. This will create a folder called nmc-website with the repo in it.

```git submodule add https://username:your_github_token_goes_here@github.com/NewMediaCaucus/nmc-website.git nmc-website```

## Step 2. Run docker build.
Don't forget the trailing dot!

```docker build -t sandbox-nmc-website .```

## Step 3. Make the entrypoint.sh script executable and run it.
Make it executable...

```chmod +x entrypoint.sh```

Now run it.

```./entrypoint.sh```

## Step 4. Create an id.env file
The id.env file is in .gitignore so it won't copy your id to GitHub.com.
 
```echo -e "USERID=$(id -u)" > id.env```

## Start the container with docker-compose
```docker-compose up -d```

## Stop the container with docker-compose
```docker-compose down```