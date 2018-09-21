module words

  implicit none

  integer, parameter :: MAX_WORD_LENGTH = 30
  character (len=2), parameter :: ly = "ly"
  integer, parameter :: MAX_ADVERB_LENGTH = MAX_WORD_LENGTH + len(ly)

contains

  function adverbtize(word, adverb) result (status)
    character (len=*), intent (in) :: word
    character (len=*), intent (out) :: adverb
    integer :: status

    adverb = trim(word) // ly
    status = 0
  end function adverbtize

end module words
