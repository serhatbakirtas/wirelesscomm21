function [Modulation,TargetCodeRate,ModOrder] = chooseMCS(G,a,tableind)
%CHOOSEMSC finds the modulation order and target code rate given SNR
nstream = numel(G);
TargetCodeRate = zeros(nstream,1);
if tableind == 1
MCS = [0 2 120;1 2 157; 2 2 193;3 2 251;4 2 308;5 2 379; 6 2 449;
    7 2 526; 8 2 602; 9 2 679; 10 4 340; 11 4 378; 12 4 434;
    13 4 490; 14 4 553; 15 4 616; 16 4 658; 17 6 438; 18 6 466;
    19 6 517; 20 6 567; 21 6 616; 22 6 666; 23 6 719; 24 6 772;
    25 6 822; 26 6 873; 27 6 910; 28 6 948];
elseif tableind == 2
MCS = [0 2 120; 1 2 193;2 2 308;3 2 449;4 2 602; 5 4 378; 6 4 434;
    7 4 490; 8 4 553; 9 4 616; 10 4 658; 11 6 466; 12 6 517;
    13 6 567; 14 6 616; 15 6 666; 16 6 719; 17 6 772;
    18 6 822; 19 6 873; 20 8 682.5; 21 8 711; 22 8 754; 23 8 797;
    24 8 841; 25 8 885; 26 8 916.5; 27 8 948];
end
MCS = [MCS MCS(:,2).*MCS(:,3)/1024];
ind = zeros(nstream,1);
for i=1:nstream
    sort_vec = find(a*log2(1+G(i))<MCS(:,4));
    if isempty(sort_vec)
        Modulation(i,1) = "256QAM";
        TargetCodeRate(i) = MCS(end,3)/1024;
        ModOrder(1,i) = 8;
    else
        ind(i) = max(sort_vec(1)-1,1);
        TargetCodeRate(i) = MCS(ind(i),3)/1024;
        if MCS(ind(i),2)==2
            Modulation(i,1) = "QPSK";
            ModOrder(1,i) = 2;
        elseif MCS(ind(i),2)==4
            Modulation(i,1) = "16QAM";
            ModOrder(1,i) = 4;
        elseif MCS(ind(i),2)==6
            Modulation(i,1) = "64QAM";
            ModOrder(1,i) = 6;
        elseif MCS(ind(i),2)==8
            Modulation(i,1) = "256QAM";
            ModOrder(1,i) = 8;
        end
    end
end
end

