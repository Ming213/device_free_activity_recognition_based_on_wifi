clc;
clear;
 fileName = fullfile([pwd '\data'],'lyingInTraceLos3.dat');
 csi_trace_los = read_bf_file(fileName);
 l = length(csi_trace_los);
 
 for i=1:l 
    
     csi_energy_los = csi_trace_los {i};  
     csi_energy = get_scaled_csi(csi_energy_los);
     
     [M N S] = size(csi_energy);
     
     if (M >= 2)
         c = mean(csi_energy);
         csi_trace = squeeze(c);
     else
         csi_trace = squeeze(csi_energy);
     end

     csiData(i,:) = ifft(sum(csi_trace));
     csiData1(i,:) = db(abs(csiData(i,:)));
     
 end

meanCSI = mean(csiData1);
x =1:1:30;
k = dtw(meanCSI, x);

%figure;
% plot(meanCSI, 'k*', 'MarkerSize', 5); 
% kmeans(x, round(k))