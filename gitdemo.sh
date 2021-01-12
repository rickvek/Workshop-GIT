#! /bin/bash

clear
cd ~/Public/
if [ -d gitdemo ]
then
    rm -rf gitdemo
    echo "Cleaned up old demo"
fi

set -v
mkdir gitdemo
cd gitdemo
# git init --bare .
git init  .
ls -la
set +v

Where() {
  read -p " ** Lets see where we are "
  clear
  set -v
  git log --oneline --graph
  set +v
  read -p "Press enter to continue"
  clear
}

MakeRelease() {
  clear
  set -v
  git checkout release
  # we should do a rebase,  like a roll forwards. clean history.
  # !!!  only to be used localy, for uploading a clean banch.
  # git merge development
  # use --continue  after resolving merge conflicts.
  git rebase development  --verbose
  # git merge development
  set +v
}

read -p " ** content empty repository, lets make .gitignore."
clear
set -v
cp ~/Documents/Presentations/MyPresentations/GIT/.gitignore .
set +v
read -p " ** lets view the contents"
less .gitignore
clear
set -v
ls -la  .git
set +v
read -p " ** content of git directory, lets see config local/global."
less .git/config
set -v
git config --list
# git config --global --list
set +v

read -p " ** no master yet, so lets make one"
set -v
clear
git branch
git add --all
git commit -m " ##  Starting"
git status
git log --oneline
set +v
read -p "Press enter to continue"
set -v
git branch release
git checkout release
git branch development
git checkout development
git log --oneline
git branch
set  +v
echo "Note: development branch is created from release"
read -p " ** Start of NF"
clear
echo "Note:  we are on branch development"
set -v
git branch NF
git checkout NF
mkdir NF
echo " $(date +%D%T) ** Start of New Feature"  >> README.md
git add --all
git commit -m "NF: Start of New Feature"
git status
set +v

read -p " ** Start of P1 "
clear
set -v
git checkout development
git checkout -b P1
mkdir P1
echo "$(date +%D%T) ** Start of Project 1" >> README.md
git add --all
git commit -m "P1:  start of P1"
git status
set +v

read -p " ** lets start with project Project 1"
clear
#git checkout P1
count=1
while [ $count -lt 10 ]
 do touch P1/P1_file.$count
 ((count++))
done
set -v
git add --all
git commit -m "P1: Created files"
git status
set +v

read -p " ** now we have one commit with a number of files"
clear
set -v
count=1
while [ $count -lt 10 ]
 do echo "Hi there !!" >> P1/P1_file.$count
 ((count++))
done
git add --all
git commit -m "P1: filed the files  "
git status
set +v

#some work on New Feature
read -p " ** in the mean time New Feature sprint has started."
clear
set -v
git checkout NF
count=1
while [ $count -lt 20 ]
 do echo "Sweating already" >> NF/NF_file.$count
 ((count++))
done
git add --all
git commit -m "NF: first files NF"
git status
set +v

Where
#back to Project 1, ending, merging, cleaning up
read -p " ** finishing P1"
set -v
git checkout development
git merge P1 -m "Merge of Project 1"
git branch -d P1
git branch
set +v

read -p " ** Lets see where we are "
clear
set -v
git log --graph
set +v

read -p  "work continues on NF"
clear
read -p " **  We said you cannot commit to much ,  so we do it for every file "
set -v
git checkout NF
count=15
while [ $count -lt 31 ]
 do echo "Some more work done" >> NF/NF_file.$count
 set -v
 git add NF/NF_file.$count
 git commit -m "NF: commit file NF_file.$count"
 set +v
 (( count++ ))
done
echo "Now we done 30 changes and 30 commits"
set -v
git status
set +v

read -p " ** Lets prepare a release project 1"
clear
MakeRelease
read -p " ** set a tag "
set -v
git tag -a 1.0 -m "Demo_Rel_v1.0"
git tag
set +v
read -p
clear
Where

read -p " ** Lets do a hotfix"
set -v
git checkout development
git branch HF
git checkout HF
count=5
while [ $count -lt 10 ]
 do
  echo "Some HOTFIX  work done" >> P1/P1_file.$count
  git add --all
  git commit -m "HF: commit file P1_file.$count"
  ((count++))
done
git status
echo "$(date +%D%T) ** HOTFIX:  done some fixes" >> README.md
git add --all
git commit -m "HF: finished a hot fix"
git status
git checkout development
git merge HF -m "Merge of HOTF
IX"
git branch -d HF
set +v

read -p " ** Lets prepare a release hot fix "
clear
MakeRelease
set +v
read -p " ** set a tag"
clear
set -v
git tag -a 1.1 -m "Demo_Rel_v1.1"
git tag
set +v
read -p
clear
Where

read -p " **  Now we start second project  Project 2 "
set -v
git checkout development
git checkout -b P2
mkdir P2
echo "$(date +%D%T) ** start Project 2 " >> README.md
git add --all
git commit -m "Project 2: started"
git status
set +v
count=1
while [ $count -lt 10 ]
 do
  echo "Some new  work done" >> P2/P2_file.$count
  git add --all
  git commit -m "P2: commit file P2_file.$count"
  ((count++))
done
set -v
git status
set +v

read -p " ** Lets do a less happy flow"
clear
set -v
git status
git diff
echo "let's see what happens "  >> P2/P2_file.7
git commit -m "P2: Done for now"
git diff
git status
git add --all
git status
git status
set +v

Where

read -p " ** last usage of New Feature"
set -v
git checkout NF
count=30
while [ $count -lt 61 ]
 do
  echo "pff almost there" >> NF/NF_file.$count
  git add --all
  git commit -m "NF: commit file NF_file.$count"
 ((count++))
done
git status
git add --all
git commit -m "New Feature: last files NF"
git status
set +v

Where

read -p " **  now finish Project 2 "
set -v
git checkout development
git merge P2 -m "Merging P2 into development"
git branch -d P2
set +v
read -p "Check for merge conflict in other screen"
MakeRelease
set +v
read -p " ** lets set a tag"
clear
set -v
git tag -a 2.0 -m  "Demo_Rel_v2.0"
git tag
set +v
Where

read -p " ** Let's finish the new feature branch"
set -v
git checkout NF
echo "$(date +%D%T) ** New Feature: finished new features " >> README.md
git add --all
git commit -m "New Feature:  finishing this, finally....."
git status
set +v

read -p " ** lets release the last part "
set -v
git checkout development
git status
set +v
read -p "check development status"
set -v
git merge NF -m "Merge of New Feature"
git branch -d NF
set +v
read -p "Check for merge conflict in other screen"
MakeRelease
git tag -a 3.0 -m "Demo_Rel_v3.0"
git tag
set +v
Where

echo  "  ####  THE END ###  "
