%matlab���߶�Ч
x = 0:2*pi/199:2*pi;
y = x.*sin(x).^2;
dt = 1/500;
% fps = 40; %����д����Ƶ֡��
% myVideo = VideoWriter('test2.avi'); %����д����Ƶ�ļ��� 
% myVideo.FrameRate = fps; 
% open(myVideo); %����Ƶ�ļ�����ʼд��
h=animatedline; %������������
for k = 1:200
    addpoints(h,x(k),y(k)); %������Ƶ�����������
    axis([0,2*pi,0,max(y)]),drawnow
    frame = getframe(gcf);%����ǰ������ΪĿ��֡
    im = frame2im(frame);%�������ӰƬ֡תΪͼ������
%     writeVideo(myVideo,im);  %��imд����Ƶ�ļ���ǰ֡
    [I,map] = rgb2ind(im,128);%��imת��Ϊ����128����ɫ������ͼ��
    if k>1
        imwrite(I,map,'test1.gif','WriteMode','append','DelayTime',dt);%��ÿһ֡���뵽gif��
    else
       imwrite(I,map,'test1.gif','LoopCount',Inf,'DelayTime',dt);%���Ƶ�һ֡ʱ���г�ʼ��
    end
end
% close(myVideo);  %�ر�
