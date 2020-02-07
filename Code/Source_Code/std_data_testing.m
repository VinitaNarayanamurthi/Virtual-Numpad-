clc
clear all
close all
r = load('C:\Users\vinit\Desktop\bio_lab_project\std_dataset\Database1\female_1.mat');
alldata= [r.cyl_ch1 r.cyl_ch2;r.hook_ch1,r.hook_ch2; r.tip_ch1,r.tip_ch2;r.palm_ch1, r.palm_ch2; r.spher_ch1, r.spher_ch2;r.lat_ch1,r.lat_ch2];

y=[ones(30,1) ; 2*ones(30,1); 3*ones(30,1); 4*ones(30,1); 5*ones(30,1); 6*ones(30,1);];

for i=1:30
    x(i,:)=KSM1([alldata(i,1:3000)' alldata(i,3001:6000)']);
    x(i+30,:)=KSM1([alldata(i+30,1:3000)' alldata(i+30,3001:6000)']);
    x(i+60,:)=KSM1([alldata(i+60,1:3000)' alldata(i+60,3001:6000)']);
    x(i+90,:)=KSM1([alldata(i+90,1:3000)' alldata(i+90,3001:6000)']);
    x(i+120,:)=KSM1([alldata(i+120,1:3000)' alldata(i+120,3001:6000)']);
    x(i+150,:)=KSM1([alldata(i+150,1:3000)' alldata(i+150,3001:6000)']);
end

xnorm=(x-ones(180,1)*min(x))./(ones(180,1)*(max(x)-min(x)));

xy=[xnorm y];

