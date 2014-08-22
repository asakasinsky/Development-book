http://amoffat.github.io/sh/  

## python setup.py uninstall

You need to remove all files manually, and also undo any other stuff that installation did manually.

If you don't know the list of all files, you can reinstall it with the --record option, and take a look at the list this produces.

To record list of installed files, you can use:

python setup.py install --record files.txt
Once you want to uninstall you can use xargs to do the removal:

cat files.txt | xargs rm -rf


