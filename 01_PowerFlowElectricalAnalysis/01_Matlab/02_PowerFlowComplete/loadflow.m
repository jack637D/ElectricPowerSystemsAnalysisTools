%%  Initial comments. loadflow.m
%   
%   Author: Pedro Henrique Neves dos Santos (pneves) 
%   License: MIT License 
%   Based on file loadflow_v3.m from prof. Castro
%
%   Last modification: 02/05/2020
%%
%pneves: Clear screen and all variables from workspace
clear all;
clc;

%%
%pneves: Start time tracking 
tic; % iniciando contagem de tempo computacional

fprintf('\n')
fprintf('> ---------------------------------\n')
fprintf('> Loadflow                         \n')
fprintf('> Fluxo de carga - m�todo de Newton\n')
fprintf('> Pedro Henrique Neves dos Santos  \n')
fprintf('> pneves                           \n')
fprintf('> Baseado em software prof. Castro \n')
fprintf('> ---------------------------------\n')
fprintf('\n')
fprintf('> Carregando dados da simula��o ...\n')

%%
%pneves: Some script configs

%tol		=	0.000000000001; 
tol		=	0.00001;

%   Arquivo de dados da rede
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
%IEEE14

fprintf('\n> %s\n', nome_da_rede); 


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

%%
%	Determinacao do tamanho da rede
fprintf('\n> Processando dados da rede ...\n')

%pneves: nb and nr are varibles of interest.
%pneves: variable colunas won't be used. 
[nb , colunas] = size(barras);
[nr , colunas] = size(ramos);

%%
%	Carregamento dos vetores de barra

%pneves: extracting bar values into arrays
%pneves: for 1 through nb (N�mero de barras) 
%N�mero - Tipo - V - �ngulo - Pg - Qg - Pc - Qc - bshk
for k = 1:nb
    numext(k)   = barras(k,1);                  
    tipo(k)     = barras(k,2);                  
    v(k)        = barras(k,3);                  
    ang(k)      = barras(k,4) * graus_to_rad;   
    pg(k)       = barras(k,5)/baseMVA;        
    qg(k)       = barras(k,6)/baseMVA;
    pc(k)       = barras(k,7)/baseMVA;
    qc(k)       = barras(k,8)/baseMVA;
    bshk(k)     = barras(k,9)/baseMVA;

    pnom(k)     = pg(k) - pc(k);
    qnom(k)     = qg(k) - qc(k);

    numint(barras(k,1)) = k;
    
end

%	Carregamento dos vetores de ramo
for l = 1:nr
	de(l)   = ramos(l,1);
	para(l) = ramos(l,2);
	r(l)    = ramos(l,3);
	x(l)    = ramos(l,4);
	bshl(l) = ramos(l,5)/2.;
	tap(l)  = ramos(l,6);
	fi(l)   = 0; %- ramos(l,7) * graus_to_rad;
    
%     if tap(l) == 0
%        tap(l) = 1.0;
%     end
end

fprintf('\n> Modelo de carga: pot�ncia constante (default).\n')

%%
%	Montar matriz admit�ncia nodal
%	-> transformadores defasadores n�o s�o considerados aqui

fprintf('\n> Executando c�lculo de fluxo de carga ...\n')

%pneves: prealocating matrix with zeros
Y = zeros(nb,nb);


for k = 1:nb
	Y(k,k) = i*bshk(k);
end

for l = 1:nr
    k = de(l);
    m = para(l);

    y(l) = 1/(r(l) + i*x(l));

    akk(l) = 1/(tap(l)*tap(l));
    amm(l) = 1.0;
    akm(l) = 1/tap(l);

    Y(k,k) = Y(k,k) + akk(l)*y(l) + i*bshl(l);
    Y(m,m) = Y(m,m) + amm(l)*y(l) + i*bshl(l);
    Y(k,m) = Y(k,m) - akm(l)*y(l);
    Y(m,k) = Y(m,k) - akm(l)*y(l);
end

G = real(Y);
B = imag(Y);

%%
%	Defini��o do estado inicial da rede
%	-> v = 1 pu para barras PQ
%	-> ang = 0 para barras PQ e PV


for k = 1:nb
	if tipo(k) ~= 3
        ang(k) = 0.0;
  	  	if tipo(k) < 2
			v(k)= 1.0;
		end
    end
end

%%
%	Inicializar contador de itera��es
iter = 0;

%	Inicializar maiores mismatches
maxDP = 10^5;
maxDQ = 10^5;

%	Processo iterativo
%pneves: while mismatch maxDP greater than tolerance OR
%pneves: while mismatch maxDQ greater than tolerance
while abs(maxDP) > tol | abs(maxDQ) > tol
    %C�lculo das pot�ncias nodais

    for k = 1:nb
        pcalc(k) =  G(k,k)*v(k)*v(k);
        qcalc(k) = -B(k,k)*v(k)*v(k);
    end

    for l = 1:nr
        k = de(l);
        m = para(l);

        ab = ang(k) - ang(m) + fi(l);

        gkm = akm(l)*real(y(l));
        bkm = akm(l)*imag(y(l));

        pcalc(k) = pcalc(k) + v(k)*v(m)*(-gkm*cos(ab)-bkm*sin(ab));
        pcalc(m) = pcalc(m) + v(k)*v(m)*(-gkm*cos(ab)+bkm*sin(ab));
        qcalc(k) = qcalc(k) + v(k)*v(m)*(-gkm*sin(ab)+bkm*cos(ab));
        qcalc(m) = qcalc(m) - v(k)*v(m)*(-gkm*sin(ab)-bkm*cos(ab));
    end

    %C�lculo dos mismatches de pot�ncia
    DP = zeros(nb,1);
    DQ = zeros(nb,1);
    maxDP = 0;
    maxDQ = 0;
    busDP = 0;
    busDQ = 0;

    for k = 1:nb
        pesp(k) = pnom(k);
        qesp(k) = qnom(k);

        if tipo(k) ~= 3
            DP(k) = pesp(k) - pcalc(k);
            if abs(DP(k)) > abs(maxDP)
                maxDP = DP(k);
                busDP = numext(k);
            end
        end
        
        if tipo(k) <= 1
            DQ(k) = qesp(k) - qcalc(k);
            if abs(DQ(k)) > abs(maxDQ)
                maxDQ = DQ(k);
                busDQ = numext(k);
            end
        end
    end

    iteracao(iter+1) = iter;
    mismP(iter+1) = abs(maxDP);
    mismQ(iter+1) = abs(maxDQ);

    DS = [ DP ; DQ ];

    fprintf('\n> Itera��o - %d\n',iter)
    fprintf('  * M�ximo mismatch P = %06.4f (barra %04d)\n',maxDP,busDP)
    fprintf('  * M�ximo mismatch Q = %06.4f (barra %04d)\n',maxDQ,busDQ)

    if abs(maxDP) > tol | abs(maxDQ) > tol

        %	Montar e inverter a matriz Jacobiana
        H = zeros(nb,nb); M=H; N=H; L=H;

        for k = 1:nb
            H(k,k) = -qcalc(k) - v(k)*v(k)*B(k,k);
            if tipo(k) == 3
                H(k,k) = 10^10;
            end
            N(k,k) = ( pcalc(k) + v(k)*v(k)*G(k,k) )/v(k) ;
            M(k,k) = pcalc(k) - v(k)*v(k)*G(k,k);
            L(k,k) = ( qcalc(k) - v(k)*v(k)*B(k,k) )/v(k) ;
            if tipo(k) >= 2
                L(k,k) = 10^10;
            end
        end

        for l = 1 : nr,
              k = de(l) ;
              m = para(l) ;

              ab = ang(k) - ang(m) + fi(l) ;

              H(k,m) =   v(k)*v(m)*( G(k,m)*sin(ab)-B(k,m)*cos(ab)) ;
              H(m,k) =   v(k)*v(m)*(-G(k,m)*sin(ab)-B(k,m)*cos(ab)) ;
              N(k,m) =   v(k)*(G(k,m)*cos(ab)+B(k,m)*sin(ab)) ;
              N(m,k) =   v(m)*(G(k,m)*cos(ab)-B(k,m)*sin(ab)) ;
              M(k,m) = - v(k)*v(m)*(G(k,m)*cos(ab)+B(k,m)*sin(ab)) ;
              M(m,k) = - v(k)*v(m)*(G(k,m)*cos(ab)-B(k,m)*sin(ab)) ;
              L(k,m) =   v(k)*(G(k,m)*sin(ab)-B(k,m)*cos(ab)) ;
              L(m,k) = - v(m)*(G(k,m)*sin(ab)+B(k,m)*cos(ab)) ;
        end


        J = [ H N ; M L ];

        %	Calcular o vetor de corre��o de estado

        DV = inv(J)*DS;

        %	Atualizar estado
        v = v + DV(nb+1:2*nb)';
        ang = ang + DV(1:nb)';
        

        %	Verificar se houve diverg�ncia
        for k = 1:nb
            if v(k) < vmin | v(k) > vmax
                fprintf('\n> Tens�es fora dos limites -> diverg�ncia.\n')
                fprintf('> Execu��o interrompida.\n\n')
                if graf == 'sim'
                            graficos
                end
                msgbox('Tens�es fora dos limites -> diverg�ncia. Execu��o interrompida.','Aviso','warn');
                return
            end
        end

    %	Incrementar contador de itera��es

    iter = iter + 1;

        if iter > itmax
            fprintf('\n> N�mero m�ximo de itera��es permitido foi excedido.\n')
            fprintf('> Execu��o interrompida.\n\n')
            if graf == 'sim'
                graficos
            end
            msgbox('N�mero m�ximo de itera��es permitido foi excedido. Execu��o interrompida.','Aviso','warn');
            return
        end
    end
end	% final do while

%%
%'Fim do c�lculo de fluxo de carga. Preparando relat�rio de sa�da ...');

fprintf('\n> Fim do c�lculo de fluxo de carga. Preparando relat�rio de sa�da ...\n')

%	C�lculo das pot�ncias nodais

for k = 1:nb
	pcalc(k) = G(k,k)*v(k)*v(k);
    qcalc(k) = -B(k,k)*v(k)*v(k);
end

for l = 1:nr
	k = de(l);
    m = para(l);

    ab = ang(k) - ang(m) + fi(l);

    gkm = akm(l)*real(y(l));
    bkm = akm(l)*imag(y(l));

    pcalc(k) = pcalc(k) + v(k)*v(m)*(-gkm*cos(ab)-bkm*sin(ab));
    pcalc(m) = pcalc(m) + v(k)*v(m)*(-gkm*cos(ab)+bkm*sin(ab));
    qcalc(k) = qcalc(k) + v(k)*v(m)*(-gkm*sin(ab)+bkm*cos(ab));
    qcalc(m) = qcalc(m) - v(k)*v(m)*(-gkm*sin(ab)-bkm*cos(ab));

end

%	C�lculo dos fluxos de pot�ncia nos ramos

for l = 1:nr
    k = de(l);
    m = para(l);

    gkm = real(y(l));
    bkm = imag(y(l));
    ab = ang(k) - ang(m) + fi(l);
    vkm = v(k)*v(m);

    pkm(l) = akk(l)*v(k)*v(k)*gkm - akm(l)*vkm*(gkm*cos(ab)+bkm*sin(ab));
    pmk(l) = amm(l)*v(m)*v(m)*gkm - akm(l)*vkm*(gkm*cos(ab)-bkm*sin(ab));
    qkm(l) = -akk(l)*v(k)*v(k)*(bkm+bshl(l)) + akm(l)*vkm*(bkm*cos(ab)-gkm*sin(ab));
    qmk(l) = -amm(l)*v(m)*v(m)*(bkm+bshl(l)) + akm(l)*vkm*(bkm*cos(ab)+gkm*sin(ab));

    pperdas(l) = pkm(l) + pmk(l);
    qperdas(l) = qkm(l) + qmk(l);
end

%	Relat�rio final

fprintf('\n\n> Relat�rio final\n\n')
%fprintf('> Rede: %s\n',nome_da_rede)
fprintf('  Convergiu em %d itera��es\n\n',iter)
fprintf('> Estado da rede\n\n')
fprintf('  Barra Tipo       Mag   Fase         P       Q       Qsh\n')

for k = 1:nb
	fprintf('%7d %4d %9.4f %6.2f %9.4f %7.4f %9.4f \n',numext(k),tipo(k),v(k),(ang(k)*rad_to_graus),pcalc(k),qcalc(k), bshk(k)*v(k)^2)
end

fprintf('\n> Fluxos de pot�ncia\n\n')
fprintf('     De Para       Pkm     Qkm       Pmk     Qmk     Ploss   Qloss\n')

for l = 1:nr
	fprintf('%7d %4d %9.4f %7.4f %9.4f %7.4f %9.4f %7.4f\n',de(l),para(l),pkm(l),qkm(l),pmk(l),qmk(l),pperdas(l),qperdas(l))
end

if graf == 'sim'
    graficos
end

tempo = toc; % terminando contagem de tempo computacional

fprintf('\n\n> Tempo computacional = %7.4f segundos.',tempo)

fprintf('\n\n> Fim da simula��o.\n\n')





