iniciar :- hipotese(Instrumento),
      write('Eu acho que o instrumento é: '),
      write(Instrumento),
      nl,
      undo.

/* hipóteses a serem testadas */
hipotese(violão)   :- violão, !.
hipotese(guitarra)   :- guitarra, !.
hipotese(violino)   :- violino, !.
hipotese(cavaquinho)   :- cavaquinho, !.
hipotese(baixo)   :- baixo, !.
hipotese(piano)   :- piano, !.
hipotese(orgao)   :- orgao, !.
hipotese(teclado) :- teclado, !.
hipotese(xilofone) :- xilofone, !.
hipotese(bateria) :- bateria, !.
hipotese(desconhecido).             /* sem diagnóstico */

/* Regras de identificação dos instrumentos */
violão :- possui_seis_cordas,
           eacustico.

guitarra :- possui_seis_cordas,
           not(eacustico).
           
violino :- possui_quatro_cordas,
           eacustico, possui_arco_madeira.
           
cavaquinho :- possui_quatro_cordas,
           eacustico, not(possui_arco_madeira).

baixo :- possui_quatro_cordas,
           not(eacustico).

piano :- possui_teclas,
           not(usa_ar_para_conduzir_som), not(e_eletrico).

orgao :- possui_teclas,
           usa_ar_para_conduzir_som.

teclado :- possui_teclas,
           not(usa_ar_para_conduzir_som), e_eletrico.

xilofone :- possui_baquetas,
           possui_bolas_nas_baquetas.

bateria :- possui_baquetas,
           not(possui_bolas_nas_baquetas).

/* regras de classificação */
possui_seis_cordas :- verificar(ele_possui_seis_cordas).
possui_quatro_cordas :- verificar(ele_possui_quatro_cordas).

eacustico :- verificar(e_acustico).
possui_arco_madeira :- verificar(ele_possui_arco_de_madeira).

possui_teclas :- verificar(ele_possui_teclas).
usa_ar_para_conduzir_som :- verificar(ele_usa_ar_para_conduzir_som).

e_eletrico :- verificar(ele_e_eletrico).

possui_baquetas :- verificar(ele_possui_baquetas).

possui_bolas_nas_baquetas :- verificar(ele_possui_bolas_nas_baquetas).

/* Como fazer perguntas */
perguntar(Questão) :-
    write('O instrumento tem o seguinte atributo: '),
    write(Questão),
    write(' (s|n) ? '),
    read(Resposta),
    nl,
    ( (Resposta == sim ; Resposta == s)
      ->
       assert(yes(Questão)) ;
       assert(no(Questão)), fail).

:- dynamic yes/1,no/1.

/* Como verificar algo */
verificar(S) :-
   (yes(S)
    ->
    true ;
    (no(S)
     ->
     fail ;
     perguntar(S))).

/* Desfaz todas as afirmações sim / não */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
