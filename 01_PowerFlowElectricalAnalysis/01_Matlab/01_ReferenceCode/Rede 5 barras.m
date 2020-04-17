%	Dados da rede

nome_da_rede = 'Rede de 5 barras e 7 ramos - Material do Castro';

baseMVA      = 100 ; % MVA
Vbase = 132; %kV

%	Dados das barras
%
%	barra - r+ - x+ - r0 - x0
%
geradores = [
       1   0.00   2.27   0.0   0.77
       2   0.00   0.00   0.0   0.00
       3   0.00   4.16   0.0   1.05
       4   0.00   0.00   0.0   0.00
       5   0.00   0.00   0.0   0.00

];

%	Dados dos ramos
%
%	De - Para - r+ - x+ - r0 - x0
%
%	Dados em pu e em graus
%	bsh - carregamento total
%	modelo do transformador:  | tap:1 - x |

ramos  = [
       1   2   0.00   2.47   0.0   10.63
       2   4   0.00   2.47   0.0   10.63
       2   3   0.00   2.68   0.0   11.48
       1   4   0.00   2.42   0.0   10.40
       4   5   0.00   3.06   0.0   13.04
       3   5   0.00   2.73   0.0   11.70

       ];


