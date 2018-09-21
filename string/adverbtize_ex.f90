program adverbtize_ex

  use words
  implicit none

  character (len=MAX_WORD_LENGTH) :: word_in
  character (len=MAX_ADVERB_LENGTH) :: adverb_out
  integer :: status

  word_in = "bike"
  status = adverbtize(word_in, adverb_out)
  
  write(*,*) "Adverbtize example"
  write(*,*) "Word: ", word_in
  write(*,*) "Adverb: ", adverb_out

end program adverbtize_ex
