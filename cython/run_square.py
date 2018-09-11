"""An example of calling a Fortran function built through cython."""

import numpy as np
from f_square import square


n = 5
x = np.arange(n, dtype=np.int32)

r = square(x)

print('Square array example')
print('Numbers:', x)
print('Their squares:', r)
