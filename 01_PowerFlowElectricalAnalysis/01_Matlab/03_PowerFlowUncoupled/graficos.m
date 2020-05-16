%	------------------------------------------------------------------------
%
%	graficos.m
%
%	Mostra gr�ficos
%
%	�ltima modifica��o: 22 ago 2001
%
%	------------------------------------------------------------------------

%	Plots

%	Evolu��o dos mimatches de pot�ncia
figure (1);
plot (iteracao,mismP,iteracao,mismQ);
ylabel('M�ximos mismatches [pu] - valores absolutos');
xlabel('Itera��o');
title('Evolu��o dos mismatches de pot�ncia');
legend('Mismatches P','Mismatches Q',0);
set(gca,'XTick',1:1:iter);

%	Perfil de tens�es
figure (2);
plot (numext,v,'*-');
%bar (numext,v);
ylabel('Magnitude de tens�o [pu]');
xlabel('Barra');
title('Perfil de tens�o');
axis([ 1 nb 0 1.2 ]);
set(gca,'XTick',1:1:nb);

