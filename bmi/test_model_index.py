"""Test the model-counting functionality of the interoperability code."""

import pytest

from bmi_heat import Heat


def test_reset_index():
    m = Heat()
    m.initialize("")
    m.finalize()
    assert m._get_model_index() == -1


def test_reuse_index():
    m = Heat()
    m.initialize("")
    m.finalize()
    n = Heat()
    ni = n._get_model_index()
    n.initialize("")
    n.finalize()
    assert ni == 1


def test_first_model_gets_first_index():
    m = Heat()
    assert m._get_model_index() == 1


def test_second_model_gets_second_index():
    n = Heat()
    assert n._get_model_index() == 2


def test_too_many_models():
    p = Heat()
    with pytest.raises(MemoryError):
        q = Heat()

