/* Name: first last */
/* 700#: 700... */
%{
#include <stdio.h>
int wc=0,lc=0,cc=0;
%}

%option noyywrap
word[a-zA-Z0-9]+
newline\n
punctuation[!,.?]+
%%
^"/*"[^*]*"*/" {printf("Comment found!\n");}
{punctuation} {printf("Punctuation found!\n");}
{word} {wc++;cc+=yyleng;}
{newline} {lc++;}
. {cc++;}
%%

int main(int argc, char** argv)
{
	if(argc>1)
	{
		FILE *file;
		file = fopen(argv[1],"r");
		if(!file)
		{
			printf("Could not open file %s\n",argv[1]);
			exit(1);
		}
		yyin = file;
	}
	yylex();
	printf("No. of words: %d\nNo. of lines: %d\nNo. of characters: %d\n",wc,lc,cc);
	return 0;
}
