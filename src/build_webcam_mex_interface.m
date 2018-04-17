mex src/WebcamMexWrapper.cpp ...
    -Ithirdparty/webcam-v4l2 ...
    -Ithirdparty/mexplus/include ...
    -Lcmake-build-debug ...
    -lwebcam -lv4l2...
    -v

%%

MC = Webcam('/dev/video0', 640, 480);
figure(1)

for i = 1:10000

tic;
f = MC.frame();
ts = toc;

imshow(f.data, 'InitialMagnification', 'fit')

text(0, 0, num2str(1/ts));
drawnow

end

%%

clear MC