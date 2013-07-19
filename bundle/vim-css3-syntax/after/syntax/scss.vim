runtime! syntax/css/*.vim
syn clear cssMediaBlock
syn region cssMediaBlock contained transparent matchgroup=cssBraces start='{' end='}' contains=TOP
