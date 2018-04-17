
capture('/dev/video0', 1280, 720);

%%

function capture(dev, w, h)

cam = Webcam(dev, w, h);
figure(1)

for i = 1:10000

tic;
f = cam.frame();
ts = toc;
text(0, 0, num2str(1/ts));
imshow(f.data, 'InitialMagnification', 'fit')
drawnow

end

clear MC

end