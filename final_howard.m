% pose analyse 2017/11/9
%
% all right reserve to howard 

%{
T1 = transl(-0.1, 0, 0) * troty(0.4);
cam1 = CentralCamera('name', 'camera 1', 'default', ...
'focal', 0.002, 'pose', T1) 
T2 = transl(0.1, 0,0)*troty(-0.4);
cam2 = CentralCamera('name', 'camera 2', 'default', ...
'focal', 0.002, 'pose', T2);
%}

calib_gui     %相机标定-未知镜头，本例使用ov7725


im1=iread('test21.jpg', 'double');
 im2=iread('test22.jpg', 'double');
 [im1,tags] = iread('test21.jpg', 'double', 'mono');
  tags.DigitalCamera
 cam = CentralCamera('image', im1, 'focal', 0.0045, ...
'resolution', [960 720])              % 'resolution', [3968 2976]
  s1 = isurf(im1);
   s2 = isurf(im2);
   m = s1.match(s2)
 
% [H,r] = m.ransac(@homography, 2)
% cam1.invH(H)
 
 [F,r] = m.ransac(@fmatrix,1e-4, 'verbose');
  E = cam.E(F)
   sol = cam.invE(E, [0,0,10]')
   
 %{  
   axis([-10 10 -10 10 -10 10])
cam.plot_camera('color','b','label')
 cam2 = CentralCamera('image', im2, 'focal', 0.0045, ...
'pose', sol) 
cam2.plot_camera('color','r','label') 
%}
   [R,t] = tr2rt(sol);
    tr2rpy(R, 'deg')
    
   % transl(sol)
    
    m.show
    idisp(im1)
plot_point(m.inlier.p1, 'w*')
idisp(im2)
   
