import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column

BRANCO = [ \t\r]+
ID = [_a-zA-Z][_a-zA-Z0-9]*
NUMERO = 0|[1-9][0-9]*

%{
    private Token createToken(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}

%%




{BRANCO} {/*Ignore*/}
"//".* {/*Ignore*/}



/*Tipos de dados*/
"texto" | "grande" { return createToken(yytext(), "Tipo_de_dado", yyline, yycolumn); }

/* Número */
{NUMERO} { return createToken(yytext(), "Numero", yyline, yycolumn); }

/* Operadores de agrupamento */
"(" { return createToken(yytext(), "Parenteses_abertura", yyline, yycolumn); }
")" { return createToken(yytext(), "Parenteses_fechamento", yyline, yycolumn); }
"{" { return createToken(yytext(), "Chave_abertura", yyline, yycolumn); }
"}" { return createToken(yytext(), "Chave_fechamento", yyline, yycolumn); } 

/*Simbolos de pontudação*/
"," { return createToken(yytext(), "Virgula", yyline, yycolumn); }
";" { return createToken(yytext(), "P_Final", yyline, yycolumn); }

/* Operadores aritmeticos */
"+" { return createToken(yytext(), "Soma", yyline, yycolumn); }
"-" { return createToken(yytext(), "Subtrai", yyline, yycolumn); }
"*" { return createToken(yytext(), "Multiplicacao", yyline, yycolumn); }
"/" { return createToken(yytext(), "Divisao", yyline, yycolumn); }

/*Linha*/
"\n" { return createToken(yytext(), "Linha", yyline, yycolumn); }

/*Operador de atribuição*/ 
"=" { return createToken(yytext(), "Op_atribuicao", yyline, yycolumn); }

/*Imprimir*/ 
"captura" { return createToken(yytext(), "Captura", yyline, yycolumn); }

/*Operadores relacionais*/ 
">" { return createToken(yytext(), "Maior_que", yyline, yycolumn); }
"<" { return createToken(yytext(), "Menor_que", yyline, yycolumn); }

/*enquanto*/ 
"enquanto" { return createToken(yytext(), "Enquanto", yyline, yycolumn); }

/*Estrura de verificação*/
"sera" |
"naosera" { return createToken(yytext(), "Est_Verificacao", yyline, yycolumn); }

/*Operadores lógicos*/
"&" | 
"|" { return createToken(yytext(), "Op_Logico", yyline, yycolumn); }

/*Fim*/ 
"fim" { return createToken(yytext(), "Fim", yyline, yycolumn); }

//Número errado
0{NUMERO} { return createToken(yytext(), "ERROR_1", yyline, yycolumn); }
// {NUMERO}{ID} { return createToken(yytext(), "ERROR_2", yyline, yycolumn); }

/* Identificador */
{ID} { return createToken(yytext(), "Identificador", yyline, yycolumn); }
. { return createToken(yytext(), "ERROR", yyline, yycolumn); }
