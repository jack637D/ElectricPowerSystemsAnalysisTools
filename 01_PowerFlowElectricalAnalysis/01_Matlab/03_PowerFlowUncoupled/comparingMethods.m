fprintf('> Compara��o entre m�todos\n')

%loadflowUncoupled
%loadflow

figure (1);
plot (pcalc_timeUncoupled(1:end,2) , pcalc_pathUncoupled(1:end,2) , '*-' );
ylabel('Pcalc');
xlabel('Tempo');
title('Evolu��o do calculo de pot�ncia');
%legend('Mismatches P','Mismatches Q',0);
%set(gca,'XTick',1:1:iter);

hold on
plot (pcalc_time(1:end,2) , pcalc_path(1:end,2) , 'o-' );

