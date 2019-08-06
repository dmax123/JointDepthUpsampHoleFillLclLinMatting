 %________________________________________________________________________
 % This file is part of the source distribution provided with
 % the following publication:
 % Y. Zhang, L. Ding and G. Sharma, ''Local-linear-fitting-based matting approach for joint hole filling and depth upsampling of RGB-D images,'' Journal of Electronic Imaging, 2019
 % 
 % The code is copyrighted by the authors. Permission to copy and use
 % this software for noncommercial use is hereby granted provided this
 % notice is retained in all copies and the papers and the distribution
 % are clearly cited.
 % 
 % The software code is provided "as is" with ABSOLUTELY NO WARRANTY
 % expressed or implied. Use at your own risk.
 % ________________________________________________________________________


function block_kernal_new(I0,dMedian0,p_x,p_y,win_size,Gj,img_idx,idx_size2,win_radius,wMode)

global idx_row idx_col sum_c idx_val
current_rgb = reshape(I0,win_size,win_size,3);
current_dm = reshape(dMedian0,win_size,win_size);
win_weight = comp_kernal_new(wMode,current_rgb,current_dm,win_radius);

Wj = diag(win_weight(:));

win_kernal = pinv(Gj*Wj*Gj');

win_L = Wj - Wj * Gj' * win_kernal * Gj * Wj;

win_idx = img_idx(p_x:p_x+win_size-1,p_y:p_y+win_size-1);
win_idx = win_idx(:);

[x,y]= meshgrid(win_idx,win_idx);
x=x(:);y=y(:);
idx_row(sum_c*idx_size2+1:(sum_c+1)*idx_size2) = y;%reshape(repmat(win_idx,1,idx_size),idx_size2,1);
idx_col(sum_c*idx_size2+1:(sum_c+1)*idx_size2) = x;%reshape(repmat(win_idx',idx_size,1),idx_size2,1);
idx_val(sum_c*idx_size2+1:(sum_c+1)*idx_size2) = win_L(:);
sum_c = sum_c+1;

end