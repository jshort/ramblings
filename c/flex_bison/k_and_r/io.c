#include <stdio.h>


// getchar() needs two ctrl-D (EOF) if there is currently
// input buffered:
// https://stackoverflow.com/questions/21260674/why-do-i-need-to-type-ctrl-d-twice-to-mark-end-of-file
int main(void) {
  int c;
  while((c = getchar()) != EOF) {
    putchar(c);
  }
  printf("Done.\n");
  return 0;
}
