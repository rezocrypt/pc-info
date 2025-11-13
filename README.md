# pc-info 

Pc-info is a simple program for displaying information about your computer.



**Created:** 2021


## Project Resources

- [Github Repo](https://github.com/rezocrypt/)
- [Website]()


# Getting Started

To get a local copy up and running follow these simple example steps.

## Prerequisites

You need to have the following things installed on your pc.

- Install `git`.

## Installation

Here are steps to download, build and install the following software.

1. Clone the repo
```sh 
git clone https://github.com/rezocrypt/pc-info
```

2. Go to the directory
```sh
cd pc-info 
```

3. Install the project to the system if needed.

```sh
./install.sh
```

6. Run the project

```sh
./resopcinfo.sh
```


# Usage


Arguments:                                                                                                                                                                                                                                 
    -r          : RAM information                                                                                                                                                                                                          
    -o          : OS information                                                                                                                                                                                                           
    -c          : CPU information                                                                                                                                                                                                          
    -d          : DISK information                                                                                                                                                                                                         
    -g          : GPU information                                                                                                                                                                                                          
    -a          : All information                                                                                                                                                                                                          
    -h          : Help information                                                                                                                                                                                                         

                                             
Options:                                                                                                                                                                                                                                   
    --no-color             : Prints output without colors                                                                                                                                                                                  
    --clear-screen         : Clears screen before printing output                                                                                                                                                                          
                                                                                                                                                                                                                                           
Errors:                                                                                                                                                                                                                                    
    WRONG ARGUMENT             : Argument not found                                                                                                                                                                                        
    ARGUMENT REPETITION ERROR      : You wrote the same argument two or more times                                                                                                                                                         
                                                                                                                                                                                                                                           
How to use:                                                                                                                                                                                                                                
First argument must be information which you want  to see for example resopcinfo -r which
will print about ram, but you also can do something like this resopcinfo -rco which will 
print information about ram, cpu and  os But remember you cannot use the same argument  
multiple times otherwise you will get an error.                                                                                                                                                            

If you want to print information without colors use  resopcinfo  --no-color  as second or third argument (not first).                                                                                                                      
And if you want to clear screen before printing information  just write  resopcinfo --clear-screen.                                                                                                                                        
                                                                                                                                                                                                            



# License

Pc-info codebase is licensed under GNU GPLv3 license. Please refer to the LICENSE.txt file for detailed information.


# Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

## Top Contributors

- [Rezocrypt](https://github.com/rezocrypt) - Original author of the project. 


# Contact

- Me - [Telegram](https://t.me/rezocrypt) - rezocrypt@gmail.com
