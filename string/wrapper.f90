module wrapper

  use iso_c_binding, only: c_char, c_int
  use words, only: adverbtize

  implicit none

  public c_adverbtize

contains

  ! Must use Fortran character arrays, not strings, for interoperability.
  subroutine c_adverbtize(word, word_length, adverb, adverb_length) bind(c)
    integer (c_int), intent (in), value :: word_length
    character (len=1, kind=c_char), intent (in) :: word(word_length)
    integer (c_int), intent (in), value :: adverb_length
    character (len=1, kind=c_char), intent (out) :: adverb(adverb_length)

    integer (c_int) :: i, status
    character (len=word_length, kind=c_char) :: word_local
    character (len=adverb_length, kind=c_char) :: adverb_local

    ! Convert `word` and `adverb` from rank-1 arrays to scalars.
    do i = 1, size(word)
       word_local(i:i) = word(i)
    enddo
    do i = 1, size(adverb)
       adverb_local(i:i) = adverb(i)
    enddo

    status = adverbtize(word_local, adverb_local)

    ! Load the `adverb_local` result back into `adverb` for output.
    ! Note that `adverb_local` is trimmed.
    do i = 1, len(trim(adverb_local))
        adverb(i) = adverb_local(i:i)
    enddo
  end subroutine c_adverbtize

end module wrapper
