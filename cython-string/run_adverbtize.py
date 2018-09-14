"""An example of calling a Fortran function built through cython."""

from f_adverbtize import adverbtize


word = 'bike'
adverb = adverbtize(word)

print('Adverbtize example')
print('Word:', word)
print('Adverb:', adverb)
