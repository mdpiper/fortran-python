"""An example of calling a Fortran function through f2py.

Use `f2py` to build a Fortran shared object that can be called from
Python::

    f2py -c mathiness.f90 -m mathiness
 
"""
from mathiness import mathiness


x = 5
r = mathiness.square(x)

print("Square example")
print("A number:", x)
print("Its square:", r)
