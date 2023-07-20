%{
#include <stdio.h>
#include <string.h>
%}

%%

"si"                        { printf("if "); }
"sino"                      { printf("else "); }
"mientras"                  { printf("while "); }
"para"                      { printf("for "); }
"hacer"                     { printf("do "); }
"repetir"                   { printf("repeat "); }
"hasta"                     { printf("until "); }
"funcion"                   { printf("def "); }
"retornar"                  { printf("return "); }

"entero"                    { printf("int "); }
"decimal"                   { printf("float "); }
"cadena"                    { printf("str "); }
"booleano"                  { printf("bool "); }

"="                         { printf("= "); }
"=="                        { printf("== "); }
"!="                        { printf("!= "); }
">"                         { printf("> "); }
">="                        { printf(">= "); }
"<"                         { printf("< "); }
"<="                        { printf("<= "); }
"+"                         { printf("+ "); }
"-"                         { printf("- "); }
"*"                         { printf("* "); }
"/"                         { printf("/ "); }
"%"                         { printf("% "); }
"&&"                        { printf("and "); }
"||"                        { printf("or "); }
"!"                         { printf("not "); }

"("                         { printf("( "); }
")"                         { printf(") "); }
"{"                         { printf(":\n"); }
"}"                         { printf("\n"); }
"["                         { printf("[ "); }
"]"                         { printf("] "); }
";"                         { printf("\n"); }
","                         { printf(", "); }
":"                         { printf(":\n"); }

[a-zA-ZáéíóúÁÉÍÓÚñÑ_][a-zA-ZáéíóúÁÉÍÓÚñÑ_0-9]*   { printf("%s ", yytext); }
[0-9]+                      { printf("%s ", yytext); }
\"[^\"]*\"                  { printf("%s ", yytext); }

[ \t]                       {}

"//"(.)*\n                  {}
"/*"([^*]|\*[^/])*"*/"     {}

.                           { printf("Carácter no reconocido: %s\n", yytext); }

%%

int main(int argc, char *argv[])
{
    if (argc != 3) {
        printf("Uso: %s archivo_entrada archivo_salida\n", argv[0]);
        return 1;
    }

    FILE *archivo_entrada = fopen(argv[1], "r");
    if (archivo_entrada == NULL) {
        printf("No se pudo abrir el archivo de entrada: %s\n", argv[1]);
        return 1;
    }

    FILE *archivo_salida = fopen(argv[2], "w");
    if (archivo_salida == NULL) {
        printf("No se pudo abrir el archivo de salida: %s\n", argv[2]);
        return 1;
    }

    yyin = archivo_entrada;

    fprintf(archivo_salida, "#!/usr/bin/env python3\n\n");

    yylex();

    fclose(archivo_entrada);
    fclose(archivo_salida);

    return 0;
}
