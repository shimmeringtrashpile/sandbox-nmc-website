# README

This details the steps for getting Docker set up to run the New Media Caucus website.

## Step 0: Install Docker Engine and Docker Compose.
### Install Docker Engine
Before we can start, you will have to install the Docker Engine on your computer. This is best done on a laptop or workstation (non-servers) by installing the Docker Desktop application. 
You can follow the official documentation here for your OS:

Linux: https://docs.docker.com/engine/install/

macOS: https://docs.docker.com/desktop/install/mac-install/

Windows: https://docs.docker.com/desktop/install/windows-install/

## Step 1: Submodule the New Media Caucus website repo.
Git's Submodule feature lets you keep a git repo inside... another... git repo! Super cool! [It's repos all the way down]([url](https://en.wikipedia.org/wiki/Turtles_all_the_way_down)).
This takes a little bit of work becuase we want to connect to two different repos with different memberships. First, you need to authenticate securely to GitHub to reach the New Media Caucus repo. This is a bit fiddly. In the 21st Century, dealing with security is a pain in the butt, but we'll get through it together. Let's do it in parts.

### Part 1a. Install the GitHub CLI (command line interface) Client.
This lets you run GitHub commands from the terminal. If you are new to git and GitHub, they may seem like the same thing, but they are different. GitHub is a platform built on top of git technology. Git commands start with "git," you can use these commands with any git hosting service such as Gitlab or BitBucket. GitHub commands begin with "gh" and only work to access GitHub services. You can't use them over at GitLab, BitBucket, etc.

The GitHub CLI Client is available at https://github.com/cli/cli.

You can install it using something like homebrew on the Mac, or you can download an installer at: 
[https://github.com/cli/cli/releases/tag/v2.57.0
](https://github.com/cli/cli/releases)

Note that if you don't see your platform (Mac, Windows, etc) you will want to click the little link at the bottom of the list that says something like "Show All Assets"
Once you have it installed, you can double check that it is working by typing:

```gh --version``` 

and you should get the application version and no errors.

### Part 1b. Create a GitHub token for yourself.
GitHub tokens are used to authenticate with GitHub repos without having to use a username and password. 

Don’t have a GitHub token? You can create one for your account at https://github.com/settings/tokens. When you are creating a token, you need to check a couple of boxes.
- Check the "repo" checkbox group:  for Full control of private repositories.
- Check the "read:org" checkbox: This is under the admin:org checkbox group.

I do myself a favor and give myself a generous expiration date of about 6 months. You do you.

OK. You will now have a token! It is a long string of characters starting with "ghp_".
Copy and paste your token into a safe place, such as your password manager, if you use one.
You should keep your own copy because GitHub will never show it to you again. If you don't have it stored somewhere else, you can't see it as GitHub. They will only let you create a new one.

### 1c. Setup GitHub CLI's authentication
To setup CLI authentication you can use GitHub's little setup cool by typing

``` gh auth login```

Using this tool, you'll go through these steps:
- ? What account do you want to log into? GitHub.com
- ? What is your preferred protocol for Git operations on this host? HTTPS
- ? Authenticate Git with your GitHub credentials? No
- ? How would you like to authenticate GitHub CLI? Paste an authentication token
- Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
- The minimum required scopes are 'repo', 'read:org'.
- ? Paste your authentication token: ****************************************
- You'll see this: ```gh config set -h github.com git_protocol https```
- ✓ Configured git protocol
- ✓ Logged in as your_username_whatever_that_is


### Part 1d. Run the submodule command.
OK. here's the submodule command. This will create a folder called nmc-website with the NMC repo in it.

```git submodule add https://github.com/NewMediaCaucus/nmc-website.git nmc-website```

You should see git doing stuff and now have the "nmc-website" folder in your project.

You now have a git repo inside another git repo! 

## Step 2. Run docker build.
From the terminal, use this command. Remember the trailing dot!

```docker build -t sandbox-nmc-website .```

## Step 3. Make the entrypoint.sh script executable and run it.
Use this command at the terminal to make it executable...

```chmod +x entrypoint.sh```

Now run it.
Notice this starts with ```./``` On Mac and Linux computers, this ./ is needed before the script to run scripts.

```./entrypoint.sh```

## Step 4. Create an id.env file
You're going to generate an id.env file for your computer. We have id.env in .gitignore so it won't share your id up to GitHub.com.
Your ID is just a simple number, such as 1001. You need Docker to use this same ID to run Apache. That way, Apache can mount your local filesystem as if it was on the server.
 
```echo -e "USERID=$(id -u)" > id.env```

## Step 5. Try it out! Start the container with docker-compose
```docker-compose up -d```

## How to stop the container with docker-compose
```docker-compose down```


## Using Submodules

Update your submodule
```git submodule update --remote```

```git submodule set-branch -b dev```

If you want to pull your branch and the submodules

```git pull --recurse-submodules```

## See Also
Alexander Sirenko has a nice tutorial: https://medium.com/@alexander.sirenko/using-github-access-token-with-submodules-5038b6d639e8
