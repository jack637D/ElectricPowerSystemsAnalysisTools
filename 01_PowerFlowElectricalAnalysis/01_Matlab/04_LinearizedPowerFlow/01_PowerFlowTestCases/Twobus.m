%	Dados da rede

nome_da_rede = 'Rede de 2 barras e 1 ramo - Material do Castro';

baseMVA      = 100 ; % MVA
Vbase = 132; %kV

%	Dados das barras
%
%	N�mero - Tipo - V - �ngulo - Pg - Qg - Pc - Qc - bshk
%
%	Dados em pu e em graus
%	3 - slack ; 2 - PV ; 0 - PQ
barras = [ 1   3   1.0112   0.00   0.00   0.00  0.00  0.00  0.00
           2   0   1.0000   0.00   0.00   0.00  100   0.00  0.00
];

%	Dados dos ramos
%
%	De - Para - r - x - bshl - tap - fi
%
%	Dados em pu e em graus
%	bsh - carregamento total
%	modelo do transformador:  | tap:1 - x |

ramos  = [
       1   2   0.01   0.05   0.00   1.00 0.00
];


