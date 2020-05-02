%	------------------------------------------------------------------------
%
%	simulacao.m
%
%	Defini��o das condi��es da simula��o
%
%	�ltima modifica��o: 18 jul 2002
%
%	------------------------------------------------------------------------



%	Software utilizado (matlab/octave)
%software	=	'matlab';
%software	=	'octave';

%	Toler�ncia de converg�ncia em pu

%tol		=	0.000000000001;
%tol		=	0.00001;

%	Arquivo de dados da rede

P2GTD
%Twobus
%Fivebus
%IEEE14
%rede_4barras
%rede_6barras
%ieee118_marina;
%syst118_noparallel;
%Sixbus_critico;
%ieee34_radial;

%	Mostrar graficos ao final do c�lculo

graf		=	'nao';

%	N�mero m�ximo de itera��es permitido

itmax		=	20;

%	Tens�es m�nima e m�xima permitidas

vmin = 0.0;
vmax = 2.0;

%	Considerar cargas dependentes da tens�o
%	Caso 'nao' -> modelo de pot�ncia constante
%	Caso 'sim' -> considerar modelos especificados pelo vetor ModeloCarga

cargasV		=	'nao';

%	Convers�o graus <-> radianos

graus_to_rad = pi/180;
rad_to_graus = 180/pi;

%	------------------------------------------------------------------------
