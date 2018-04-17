%%
frame2 = zeros([f.height, f.width, 3], 'uint8');

for h = 1:f.height
    for w = 1:f.width
        for c = 1:3
%             [h, w, c, (h-1)*3*f.width + (w-1)*3 + c]
            frame2(h, w, c) = f.data((h-1)*f.width*3 + (w-1)*3 + c);
        end
    end
end
% frame2 = reshape(f.data, [f.width*f.height, 3]);

imshow(frame2);


return
%%

clc
for h = 1:f.height
    for w = 1:f.width
        if sum(sum(frame(h,w,:) - frame2(h,w,:)))
            disp('')
        end
    end
end

return

%%
%
%
% MC = Webcam();
%
% while true
%
% f = MC.frame();

R = reshape(f.data(1:3:end), [f.width, f.height])';
G = reshape(f.data(2:3:end), [f.width, f.height])';
B = reshape(f.data(3:3:end), [f.width, f.height])';

frame = cat(3, cat(3, R, G), B);
%%

clc
h = 2;
w = 1;
sum(sum(frame(h,w,:) - frame2(h,w,:)))




%%

for h = 1:f.height
    for w = 1:f.width
        for c = 1:3
            ff(h, w, c) = f.data(h*f.height + w*f.width + c);
        end
    end
end

return

%%

mex src/WebcamMexWrapper.cpp ...
    -Ithirdparty/webcam-v4l2 ...
    -Ithirdparty/mexplus/include ...
    -Lcmake-build-debug ...
    -lwebcam -lv4l2...
    -v
%     GCC='/usr/bin/gcc-4'



%%

MC = Webcam('/dev/video0', 640, 480);

tic

for i = 1:100

f = MC.frame();
% 
% imshow(f.data)
% drawnow

end

100/toc

%%

clear MC



%%


for h = 1:f.height
    for w = 1:f.width
        for c = 1:3
            ff(h, w, c) = f.data(h*f.height + w*f.width + c);
        end
    end
end

