rm ~/.emacs
ln -L .emacs ~/.emacs
rm -r ~/.templates
mkdir -p ~/.templates
ln -L site-lisp/.templates/* ~/.templates/
