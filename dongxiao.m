%matlab曲线动效
x = 0:2*pi/199:2*pi;
y = x.*sin(x).^2;
dt = 1/500;
% fps = 40; %设置写入视频帧率
% myVideo = VideoWriter('test2.avi'); %设置写入视频文件名 
% myVideo.FrameRate = fps; 
% open(myVideo); %打开视频文件，开始写入
h=animatedline; %创建动画线条
for k = 1:200
    addpoints(h,x(k),y(k)); %将点绘制到动画线条中
    axis([0,2*pi,0,max(y)]),drawnow
    frame = getframe(gcf);%捕获当前窗口作为目标帧
    im = frame2im(frame);%将捕获的影片帧转为图像数据
%     writeVideo(myVideo,im);  %将im写入视频文件当前帧
    [I,map] = rgb2ind(im,128);%将im转化为包含128种颜色的索引图像
    if k>1
        imwrite(I,map,'test1.gif','WriteMode','append','DelayTime',dt);%将每一帧插入到gif中
    else
       imwrite(I,map,'test1.gif','LoopCount',Inf,'DelayTime',dt);%绘制第一帧时进行初始化
    end
end
% close(myVideo);  %关闭
