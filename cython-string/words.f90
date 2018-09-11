module words

  implicit none

  integer, parameter :: MAX_WORD_LENGTH = 30
  integer, parameter :: MAX_ADVERB_LENGTH = 32
  character (len=2), parameter :: ly = "ly"

contains

  function adverbtize(word, adverb) result (status)
    character (len=MAX_WORD_LENGTH), intent (in) :: word
    character (len=MAX_ADVERB_LENGTH), intent (out) :: adverb
    integer :: status

    adverb = trim(word) // trim(ly)
    status = 0
  end function adverbtize

end module words
