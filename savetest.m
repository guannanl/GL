% savepath = ['E:\29peaks\peaks.mat'];
% % 
% %  save(savepath, 'peaks');
% load(savepath);
% peaks = peaks.*1794 %um

%peaks = GL_RunAve(peaks, 51);
%newpeaks = peaks(5079:end);
%newpeaks = newpeaks.*2;

load('E:\29peaks\peaks.mat')
loglog(peaks, '-s')
grid on




load('E:\29peaks\newpeaks.mat')
newpeaks2 = newpeaks(11290:24080)

loglog(newpeaks2, '-s')
xlabel('Time(s)')
ylabel('Length(um)')
grid on

