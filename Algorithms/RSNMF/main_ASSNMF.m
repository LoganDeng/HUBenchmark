clear all

data_type = 1; %data_type  1   ��ʵӰ������
%data_type  2   ģ��Ӱ������

%%
if  data_type ==1
    %///////////////%��ʵӰ��ʵ��/////////////////////////////////////////////////
%     infilename = 'E:\�������\����\��ʢ������\��ʢ��ȥ����������';
    infilename = 'E:\�������\����\Cuprite����\cuprite';
%     outfilename = 'a';
    %���������ļ����ݵ�image  (cols*lines)*bands��
    image = freadenvi(infilename);
    cols = 190;
    lines = 250;
    R = image';%ԭʼ����RΪband *n
    R=R/10000;
    [bands,N] = size(R);
    
%     load('C:\Users\DIY\Desktop\��ʢ�ٲο�.mat')
%     load('E:\�������\����\��ʢ������\��ʢ�ٲο�����.mat')
%     M = spectral;
    %1.��ʼ��M��S
    %����
    P = 12; %�ɷָ���
    
%    load SID_initial��ʢ��2.mat;
%    load('C:\Users\DIY\Desktop\��ʢ�ٳ�ʼ��.mat')
%     M_Ini = abs(initial(R,bands,P));
%     M_Ini = hyperVca(R,P);
load('C:\Users\DIY\Desktop\A_Ini cup.mat')
    M_Ini = A_Ini;
    S_Ini = hyperFcls(R,M_Ini);
%     S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *R;
    S_Ini = max(S_Ini,0.001);%ȥ����ֵ
    S_Ini = min(S_Ini,1);%ȥ������1��ֵ
%     ini_thre = 0.001; %��ʼ��Mʱ,����SID����ֵ
%     load SID_initial��ʢ��2.mat;
    %M_Ini = SID_Intial(R,ini_thre,P);
    %M_Ini= initial(R,bands,P,N);
    %M_Ini=M_Ini/10000;
    
%     S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *R;
%     S_Ini = max(S_Ini,0.001);%ȥ����ֵ
%     S_Ini = min(S_Ini,1);%ȥ������1��ֵ
    
    %2.ASC
    thre = 10;
    [RA,MA] = ASC(R,M_Ini,thre);
    
    %3.���и���Լ����ASSNMF�������
    %����
    threshold = 0.01; %������ֵ
    thresholdAbund = 0.01; %���Լ����������ֵ
    Time = 20 ;%�������ʱ��
    maxiter = 400; %��������������
    row=lines;
    col=cols;
    u1= 0.28*N+1000;
    %  u2 =0 %5/P;
    u2 =5/P;
    [M_E,S_E,obj] = ASSNMF(R,M_Ini,S_Ini,RA,MA,threshold,thresholdAbund,maxiter,row,col,u1,u2);%���ƶ�Ԫ�ͷ��
    
    %4. ���
%     %���Ӱ�����
%     enviwrite(S_E([1:P],:)',cols,lines,P,outfilename);
%     %���ƹ�����ʾ
%     figure
%     for i=1:P
%         subplot(3,4,i);plot(1:bands,M_E(1:bands,i),'g-')
%     end
    figure
    for i=1:P
        subplot(3,4,i);
        TT = reshape(S_E(i,:),190,250);
        TT = TT';
        imshow(TT,[]);
    end
% pipei = SAMpipei(spectral,M_E);
% disp(pipei);
end
% plot(M_E(1:187,6),'-b','LineWidth',2,'DisplayName','M_E(1:187,1)','YDataSource','M_E(1:187,1)');
% figure(gcf)
% hold on;
% plot(spectral(1:187,4),':r','LineWidth',2,'DisplayName','spectral(1:187,3)','YDataSource','spectral(1:187,3)');
% xlabel('band');ylabel('reflectance');
% title('Comparison');legend('Resulting Spectral','Reference Spectral');
% figure(gcf)



%%



if data_type ==2
    %////////////////////////ģ������ʵ��////////////////////////////
    load('E:\�������\My idea\����\7��ԪSNR20����0.8��Ԫ���仯\X10.mat')
    load('E:\�������\My idea\����\7��ԪSNR20����0.8��Ԫ���仯\Abundance10.mat')
    load('E:\�������\My idea\����\7��ԪSNR20����0.8��Ԫ���仯\Reference10.mat')
%     load('E:\�������\ASSNMF\syndata_ASSNMF_25dB_pure 1.mat')
    P=10;
    row = 56; %һ��Ӱ������
    col = 56; %һ��Ӱ������
    %���������ļ�����
    M = Reference;%��ʵ��Ԫ
    S = Abundance;%��ʵ���
    [bands,N] = size(X);
    
    
    disp([('��ʼ��M,S ...')]);
    %1.��ʼ��M��S
    
%     ini_thre = 0.3; %��ʼ��Mʱ,����SID����ֵ
%     %M_Ini = SID_Intial(R,ini_thre,P);
%     %load SID_initial_0.0914.mat;
%     M_Ini= hyperAtgp( X, P );
%     S_Ini = hyperFcls(X,M_Ini);

    M_Ini = abs(initial(X,bands,P));
    S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *X;
    S_Ini = max(S_Ini,0.001);%ȥ����ֵ
    S_Ini = min(S_Ini,1);%ȥ������1��ֵ   

    % M_Ini = SID_Intial(R,ini_thre,component);
    %
    % S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *R;
    % S_Ini = max(S_Ini,0.001);%ȥ����ֵ
    % S_Ini = min(S_Ini,1);%ȥ������1��ֵ
    %
    disp([('ASC���� ...')]);
    %2.ASC
%     thre = 0.02*bands;
    thre = 15;
    [XA,MA] = ASC(X,M_Ini,thre);
    
    disp([('����ASSNMF���� ...')]);
    %3.���и���Լ����ASSNMF�������
    %����
    threshold = 0.02; %������ֵ
    thresholdAbund = 3e-5; %���Լ����������ֵ
    %  Time = 20 ;%�������ʱ��
    maxiter = 500; %��������������
    
    u1 = 0.28*N;
   
    %  u2 =0 %5/P;
    u2 =5/P;
    tic
    [M_E,S_E,obj,consobj] = ASSNMF(X,M_Ini,S_Ini,XA,MA,threshold,thresholdAbund,maxiter,row,col,u1,u2);%���ƶ�Ԫ�ͷ��
    toc
   
    pipei = SAMpipei(Reference,M_E);
    rmse = RMSE(Abundance,S_E,pipei(1,:),pipei(2,:));
    disp(pipei);
    disp(rmse);
%     disp([('�����ʾ ...')]);
    %4. ���
%     figure
%     for i=1:P
%         subplot(4,P,i);plot(1:bands,M_E(1:bands,i),'g-')
%         subplot(4,P,i+P);plot(1:bands,M(1:bands,i),'b-')
%     end
%     figure;
%     for i=1:P
%         subplot(3,4,i);
%         TT = reshape(S_E(i,:),col,row);
%         TT = TT';
%         imshow(TT,[]);
%     end
end

% plot(M_E(1:391,5),'-b','LineWidth',2,'DisplayName','M_E(1:391,1)','YDataSource','M_E(1:391,1)');
% figure(gcf)
% hold on;
% plot(Spectral(1:391,3),':r','LineWidth',2,'DisplayName','Spectral(1:391,3)','YDataSource','Spectral(1:391,4)');
% xlabel('band');ylabel('reflectance');
% title('Comparison');legend('Resulting Spectral','Reference Spectral');
% figure(gcf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [band,P1] = size(M_E);
% [P1,N]=size(S_E);
% [band,P2] = size(M);
% 
% sam = SAMpipei(M,M_E)
% sid = SIDpipei(M,M_E)
% rmse = RMSE(S,S_E,sam(1,:),sam(2,:))




