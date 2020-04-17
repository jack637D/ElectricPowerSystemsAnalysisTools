
nome_da_rede = '14 barras IEEE';

barras =[ 1   3   1.00   0.00   0.00   0.00  0.00   0.000   0.00
          2   2   1.00   0.00   0.00   0.00  0.217  0.127   0.00
          3   2   1.00   0.00   0.00   0.00  0.942  0.190   0.00
          4   0   1.00   0.00   0.00   0.00  0.478 -0.039   0.00
          5   0   1.00   0.00   0.00   0.00  0.076  0.016   0.00
          6   2   1.00   0.00   0.00   0.00  0.112  0.075   0.00
          7   0   1.00   0.00   0.00   0.00  0.000  0.000   0.00
          8   2   1.00   0.00   0.00   0.00  0.000  0.000   0.00
          9   0   1.00   0.00   0.00   0.00  0.295  0.166   0.19
         10   0   1.00   0.00   0.00   0.00  0.900  0.058   0.00
         11   0   1.00   0.00   0.00   0.00  0.350  0.018   0.00
         12   0   1.00   0.00   0.00   0.00  0.610  0.016   0.00
         13   0   1.00   0.00   0.00   0.00  0.135  0.058   0.00
         14   0   1.00   0.00   0.00   0.00  0.149  0.050   0.00];

ramos=[1    5  0.05403   0.22304     0.0492  1.000  0.00
       1    2  0.01938   0.05917     0.0528  1.000  0.00 
       2    5  0.05695   0.17388     0.0346  1.000  0.00
       2    4  0.05811   0.17632     0.0340  1.000  0.00
       2    3  0.04699   0.19797     0.0438  1.000  0.00
       3    4  0.06701   0.17103     0.0000  1.000  0.00
       4    5  0.01335   0.04211     0.0000  1.000  0.00
       4    7  0.00000   0.20912     0.0000  1.000  0.00
       4    9  0.00000   0.55618     0.0000  1.000  0.00
       5    6  0.00000   0.25202     0.0000  1.000  0.00
       6   12  0.12291   0.25581     0.0000  1.000  0.00
       6   13  0.06615   0.13027     0.0000  1.000  0.00
       6   11  0.09498   0.19890     0.0000  1.000  0.00
       7    9  0.00000   0.11001     0.0000  1.000  0.00
       7    8  0.00000   0.17615     0.0000  1.000  0.00
       9   10  0.03181   0.08450     0.0000  1.000  0.00
       9   14  0.12711   0.27038     0.0000  1.000  0.00
      10   11  0.08205   0.19207     0.0000  1.000  0.00
      12   13  0.22092   0.19988     0.0000  1.000  0.00
      13   14  0.17093   0.34802     0.0000  1.000  0.00];


ModeloCarga = [ 1	1.0     0.0     0.0     1.0     0.0     0.0;
		        2	1.0     0.0     0.0     1.0     0.0     0.0;
		        3	1.0     0.0     0.0     1.0 	0.0 	0.0;
                4	1.0     0.0     0.0     1.0     0.0     0.0;
		        5	1.0     0.0     0.0     1.0     0.0     0.0;
		        6	1.0     0.0     0.0     1.0 	0.0 	0.0;
	            7	1.0     0.0     0.0     1.0     0.0     0.0;
		        8	1.0     0.0     0.0     1.0     0.0     0.0;
		        8	1.0     0.0     0.0     1.0 	0.0 	0.0;
                10	1.0     0.0     0.0     1.0     0.0     0.0;
		        11	1.0     0.0     0.0     1.0     0.0     0.0;
		        12	1.0     0.0     0.0     1.0 	0.0 	0.0;
		        13	1.0     0.0     0.0     1.0 	0.0 	0.0;
		        14	1.0     0.0     0.0     1.0 	0.0 	0.0];

% Medidas disponiveis.
% tipos: 1- Fluxo de potencia ativa
%        2- Inje��o de potencia ativa
%        3- Fluxo de pot�ncia reativa
%        4- Inje��o de pot�ncia reativa
%        5- Medida de tens�o
% No_da_medida      tipo      de      para     valor(pu)   linha      vari�ncia
M=[
%    0                10       1       1          0.0000       0          0.001   % Medida de �ngulo

    1                 1       1       2          3.3722       2          0.002
    2                 1       1       5          1.5319       1          0.002
    3                 1       2       3          1.0307       5          0.002
    7                 1       5       4          0.7983       7          0.002
    7                 1       7       8          0.0000      15          0.002
    8                 1       7       9          0.8454      14          0.002
    6                 1       6      13          0.3778      12          0.002 %
    7                 1      10      11         -0.0434      18          0.002 %
%
    9                 2       1       0           4.9041      0          0.003
   10                 2       2       0          -0.2170      0          0.003
   11                 2       3       0          -0.9420      0          0.003
%   15                 2       6       0          -0.1120      0          0.003 %
    7                 2       8       0           0.0000      0          0.003
   14                 2      12       0          -0.6100      0          0.003
%   15                 2       9       0          -0.3500*2  0          0.0003 %restaura��o
%   15                 2      11       0          -0.2950*2  0          0.0003 %restaura��o
%   15                 2      13       0          -0.1350*2  0          0.0003 %restaura��o
%   15                 2      14       0          -0.1490*2  0          0.0003 %restaura��o
%
    1                 3       1       2          -0.7416      2          0.002
    2                 3       1       5           0.1897      1          0.002
    3                 3       2       3          -0.1537      5          0.002
    7                 3       5       4          -0.2375      7          0.002
    7                 3       7       8          -0.3030     15          0.002
    8                 3       7       9           0.1570     14          0.002
    6                 3       6      13           0.1271     12          0.002 %
    7                 3      10      11          -0.1104     18          0.002 %
%
    1                 5       1       1           1.0000      0          0.001
    4                 5       4       4           0.9301      0          0.001
    4                 5       5       5           0.9300      0          0.001
    4                 5       8       8           1.0000      0          0.001
    4                 5      11      11           0.9289      0          0.001 %
    4                 5      12      12           0.9206      0          0.001 %
%
    9                 4       1       0          -0.5519      0          0.003
   10                 4       2       0           1.5340      0          0.003
   11                 4       3       0           0.7185      0          0.003
%   15                 4       6       0           0.9492      0          0.003 %
    7                 4       8       0           0.3212      0          0.003
   14                 4      12       0          -0.0160      0          0.003
%   15                 4      13       0          -0.0580*1.2  0          0.0003 %restaura��o
%   15                 4      14       0          -0.0500*1.2  0          0.0003 %restaura��o
];

%  Barra Tipo       Mag   Fase         P       Q       Qsh
%      1    3    1.0000  -0.00    4.9041 -0.5519    0.0000
%      2    2    1.0000 -12.32   -0.2170  1.5340    0.0000
%      3    2    1.0000 -24.46   -0.9420  0.7185    0.0000
%      4    0    0.9301 -23.23   -0.4780  0.0390    0.0000
%      5    0    0.9300 -20.79   -0.0760 -0.0160    0.0000
%      6    2    1.0000 -41.97   -0.1120  0.9492    0.0000
%      7    0    0.9434 -34.85   -0.0000  0.0000    0.0000
%      8    2    1.0000 -34.85    0.0000  0.3212    0.0000
%      9    0    0.9304 -40.93   -0.2950 -0.1660    0.1645
%     10    0    0.9014 -46.00   -0.9000 -0.0580    0.0000
%     11    0    0.9289 -46.05   -0.3500 -0.0180    0.0000
%     12    0    0.9206 -47.88   -0.6100 -0.0160    0.0000
%     13    0    0.9593 -44.41   -0.1350 -0.0580    0.0000
%     14    0    0.9225 -43.72   -0.1490 -0.0500    0.0000
%
%> Fluxos de pot�ncia
%
%     De Para       Pkm     Qkm       Pmk     Qmk     Ploss   Qloss
%      1    5    1.5319  0.1897   -1.4026  0.2981    0.1293  0.4878
%      1    2    3.3722 -0.7416   -3.1419  1.3920    0.2303  0.6503
%      2    5    0.8477  0.1660   -0.8049 -0.0675    0.0428  0.0985
%      2    4    1.0464  0.1297   -0.9816  0.0355    0.0649  0.1652
%      2    3    1.0307 -0.1537   -0.9800  0.3236    0.0507  0.1700
%      3    4    0.0380  0.3949   -0.0274 -0.3680    0.0105  0.0269
%      4    5   -0.7876  0.2713    0.7983 -0.2375    0.0107  0.0338
%      4    7    0.8454  0.0269   -0.8454  0.1460    0.0000  0.1729
%      4    9    0.4732  0.0733   -0.4732  0.0741    0.0000  0.1474
%      5    6    1.3333 -0.0091   -1.3333  0.5271    0.0000  0.5180
%      6   12    0.4295  0.1233   -0.4049 -0.0722    0.0245  0.0511
%      6   13    0.3778  0.1271   -0.3673 -0.1064    0.0105  0.0207
%      6   11    0.4139  0.1717   -0.3949 -0.1317    0.0191  0.0399
%      7    9    0.8454  0.1570   -0.8454 -0.0656    0.0000  0.0914
%      7    8    0.0000 -0.3030    0.0000  0.3212    0.0000  0.0182
%      9   10    0.8854  0.0242   -0.8566  0.0524    0.0288  0.0766
%      9   14    0.1382 -0.0342   -0.1352  0.0406    0.0030  0.0063
%     10   11   -0.0434 -0.1104    0.0449  0.1137    0.0014  0.0033
%     12   13   -0.2051  0.0562    0.2168 -0.0456    0.0118  0.0107
%     13   14    0.0155  0.0940   -0.0138 -0.0906    0.0017  0.0034

