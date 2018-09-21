#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LENGTH (2048)


void c_adverbtize(char *word, int nword, char *adverb, int nadverb);


int main(int argc, char *argv[]) {

  char *word = "bike";
  int word_length = strlen(word);
  char *adverb;

  adverb = malloc(MAX_WORD_LENGTH);

  c_adverbtize(word, word_length, adverb, MAX_WORD_LENGTH);

  printf("Adverbtize example\n");
  printf("Word: %s\n", word);
  printf("Adverb: %s\n", adverb);
}
