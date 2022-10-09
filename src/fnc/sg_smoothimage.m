function b=sg_smoothimage(a,patchwidth,dispflag,colorscale)
% Function for smoothing an image using Savitzky-Golay 2D filter
% The idea adapted from John Krumm, Microsoft Research, Microsoft Corporation, Redmond, WA 98052, August 2001
% http://research.microsoft.com/users/jckrumm/SavGol/SavGol.htm
% and implemented by L.Polerecky, MPI Bremen, 8th May 2004
% improved by LP, Jan 2018

% substitute all NaN's or Inf with the minimum obtained from the meaningful
% numerical values
ind = find(isnan(a) | isinf(abs(a)));
ind1 = find(~isnan(a));
if ~isempty(ind), a(ind) = min(a(ind1)); end;

% remember min(a) and max(a)
% NOTE: in the final image, the pixels in which the values fall
% below min(a) or above max(a) will be set to min(a) and max(a),
% respectively.
mina = min(a(:));
maxa = max(a(:));

% off-set a by min(a), to avoid negative values during calculation
a = a-mina;

% extend the image periodically so that the edges will be calculated correctly
ao = a;
b = [flipud(a); a; flipud(a)];
a = [fliplr(b) b fliplr(b)];

if(nargin>1)
    pw=patchwidth;
else
    pw=5;
end;
if(nargin>2)
    display=dispflag;
else
    display=0;
end;
if(nargin>3)
    cs=colorscale;
else
    cs = [ min(a(:)) max(a(:)) ];
end;

% coefficient C00 for smoothing with patch size 3x3, polynom order 2:
if(pw==3)
    C = [-0.11111111,0.22222222,-0.11111111;
          0.22222222,0.55555556,0.22222222;
          -0.11111111,0.22222222,-0.11111111];
end;

% coefficient C00 for smoothing with patch size 5x5, polynom order 3:
if(pw==5)
    C = [-0.07428571,0.01142857,0.04000000,0.01142857,-0.07428571;
          0.01142857,0.09714286,0.12571429,0.09714286,0.01142857;
          0.04000000,0.12571429,0.15428571,0.12571429,0.04000000;
          0.01142857,0.09714286,0.12571429,0.09714286,0.01142857;
         -0.07428571,0.01142857,0.04000000,0.01142857,-0.07428571];
end;

% coefficient C00 for smoothing with patch size 7x7, polynom order 3: 
if(pw==7)
    C = [-0.04761905,-0.01360544,0.00680272,0.01360544,0.00680272,-0.01360544,-0.04761905,-0.01360544,0.02040816,0.04081633,0.04761905,0.04081633,0.02040816,-0.01360544,0.00680272,0.04081633,0.06122449,0.06802721,0.06122449,0.04081633,0.00680272,0.01360544,0.04761905,0.06802721,0.07482993,0.06802721,0.04761905,0.01360544,0.00680272,0.04081633,0.06122449,0.06802721,0.06122449,0.04081633,0.00680272,-0.01360544,0.02040816,0.04081633,0.04761905,0.04081633,0.02040816,-0.01360544,-0.04761905,-0.01360544,0.00680272,0.01360544,0.00680272,-0.01360544,-0.04761905];
    C = vec2mat(C,7);
end;

% coefficient C00 for smoothing with patch size 9x9, polynom order 3: 
if(pw==9)
    C = [-0.03254770,-0.01571268,-0.00368767,0.00352734,0.00593234,0.00352734,-0.00368767,-0.01571268,-0.03254770,-0.01571268,0.00112233,0.01314735,0.02036235,0.02276736,0.02036235,0.01314735,0.00112233,-0.01571268,-0.00368767,0.01314735,0.02517236,0.03238737,0.03479237,0.03238737,0.02517236,0.01314735,-0.00368767,0.00352734,0.02036235,0.03238737,0.03960237,0.04200738,0.03960237,0.03238737,0.02036235,0.00352734,0.00593234,0.02276736,0.03479237,0.04200738,0.04441238,0.04200738,0.03479237,0.02276736,0.00593234,0.00352734,0.02036235,0.03238737,0.03960237,0.04200738,0.03960237,0.03238737,0.02036235,0.00352734,-0.00368767,0.01314735,0.02517236,0.03238737,0.03479237,0.03238737,0.02517236,0.01314735,-0.00368767,-0.01571268,0.00112233,0.01314735,0.02036235,0.02276736,0.02036235,0.01314735,0.00112233,-0.01571268,-0.03254770,-0.01571268,-0.00368767,0.00352734,0.00593234,0.00352734,-0.00368767,-0.01571268,-0.03254770];
    C = vec2mat(C,9);
end;

% coefficient C00 for smoothing with patch size 11x11, polynom order 3: 
if(pw==11)
    C = [-0.02352193,-0.01398601,-0.00656919,-0.00127146,0.00190718,0.00296673,0.00190718,-0.00127146,-0.00656919,-0.01398601,-0.02352193,-0.01398601,-0.00445010,0.00296673,0.00826446,0.01144310,0.01250265,0.01144310,0.00826446,0.00296673,-0.00445010,-0.01398601,-0.00656919,0.00296673,0.01038356,0.01568129,0.01885993,0.01991947,0.01885993,0.01568129,0.01038356,0.00296673,-0.00656919,-0.00127146,0.00826446,0.01568129,0.02097902,0.02415766,0.02521721,0.02415766,0.02097902,0.01568129,0.00826446,-0.00127146,0.00190718,0.01144310,0.01885993,0.02415766,0.02733630,0.02839585,0.02733630,0.02415766,0.01885993,0.01144310,0.00190718,0.00296673,0.01250265,0.01991947,0.02521721,0.02839585,0.02945539,0.02839585,0.02521721,0.01991947,0.01250265,0.00296673,0.00190718,0.01144310,0.01885993,0.02415766,0.02733630,0.02839585,0.02733630,0.02415766,0.01885993,0.01144310,0.00190718,-0.00127146,0.00826446,0.01568129,0.02097902,0.02415766,0.02521721,0.02415766,0.02097902,0.01568129,0.00826446,-0.00127146,-0.00656919,0.00296673,0.01038356,0.01568129,0.01885993,0.01991947,0.01885993,0.01568129,0.01038356,0.00296673,-0.00656919,-0.01398601,-0.00445010,0.00296673,0.00826446,0.01144310,0.01250265,0.01144310,0.00826446,0.00296673,-0.00445010,-0.01398601,-0.02352193,-0.01398601,-0.00656919,-0.00127146,0.00190718,0.00296673,0.00190718,-0.00127146,-0.00656919,-0.01398601,-0.02352193];
    C = vec2mat(C,11);
end;

% coefficient C00 for smoothing with patch size 13x13, polynom order 3: 
if(pw==13)
    C = [-0.01775148,-0.01183432,-0.00699301,-0.00322754,-0.00053792,0.00107585,0.00161377,0.00107585,-0.00053792,-0.00322754,-0.00699301,-0.01183432,-0.01775148,-0.01183432,-0.00591716,-0.00107585,0.00268962,0.00537924,0.00699301,0.00753093,0.00699301,0.00537924,0.00268962,-0.00107585,-0.00591716,-0.01183432,-0.00699301,-0.00107585,0.00376547,0.00753093,0.01022055,0.01183432,0.01237224,0.01183432,0.01022055,0.00753093,0.00376547,-0.00107585,-0.00699301,-0.00322754,0.00268962,0.00753093,0.01129640,0.01398601,0.01559978,0.01613771,0.01559978,0.01398601,0.01129640,0.00753093,0.00268962,-0.00322754,-0.00053792,0.00537924,0.01022055,0.01398601,0.01667563,0.01828940,0.01882733,0.01828940,0.01667563,0.01398601,0.01022055,0.00537924,-0.00053792,0.00107585,0.00699301,0.01183432,0.01559978,0.01828940,0.01990317,0.02044110,0.01990317,0.01828940,0.01559978,0.01183432,0.00699301,0.00107585,0.00161377,0.00753093,0.01237224,0.01613771,0.01882733,0.02044110,0.02097902,0.02044110,0.01882733,0.01613771,0.01237224,0.00753093,0.00161377,0.00107585,0.00699301,0.01183432,0.01559978,0.01828940,0.01990317,0.02044110,0.01990317,0.01828940,0.01559978,0.01183432,0.00699301,0.00107585,-0.00053792,0.00537924,0.01022055,0.01398601,0.01667563,0.01828940,0.01882733,0.01828940,0.01667563,0.01398601,0.01022055,0.00537924,-0.00053792,-0.00322754,0.00268962,0.00753093,0.01129640,0.01398601,0.01559978,0.01613771,0.01559978,0.01398601,0.01129640,0.00753093,0.00268962,-0.00322754,-0.00699301,-0.00107585,0.00376547,0.00753093,0.01022055,0.01183432,0.01237224,0.01183432,0.01022055,0.00753093,0.00376547,-0.00107585,-0.00699301,-0.01183432,-0.00591716,-0.00107585,0.00268962,0.00537924,0.00699301,0.00753093,0.00699301,0.00537924,0.00268962,-0.00107585,-0.00591716,-0.01183432,-0.01775148,-0.01183432,-0.00699301,-0.00322754,-0.00053792,0.00107585,0.00161377,0.00107585,-0.00053792,-0.00322754,-0.00699301,-0.01183432,-0.01775148];
    C = vec2mat(C,13);
end;

% coefficient C00 for smoothing with patch size 15x15, polynom order 3: 
if(pw==15)
    C = [-0.01385621,-0.00993464,-0.00661639,-0.00390146,-0.00178984,-0.00028155,0.00062343,0.00092509,0.00062343,-0.00028155,-0.00178984,-0.00390146,-0.00661639,-0.00993464,-0.01385621,-0.00993464,-0.00601307,-0.00269482,0.00002011,0.00213172,0.00364002,0.00454500,0.00484666,0.00454500,0.00364002,0.00213172,0.00002011,-0.00269482,-0.00601307,-0.00993464,-0.00661639,-0.00269482,0.00062343,0.00333836,0.00544997,0.00695827,0.00786325,0.00816491,0.00786325,0.00695827,0.00544997,0.00333836,0.00062343,-0.00269482,-0.00661639,-0.00390146,0.00002011,0.00333836,0.00605329,0.00816491,0.00967320,0.01057818,0.01087984,0.01057818,0.00967320,0.00816491,0.00605329,0.00333836,0.00002011,-0.00390146,-0.00178984,0.00213172,0.00544997,0.00816491,0.01027652,0.01178482,0.01268979,0.01299145,0.01268979,0.01178482,0.01027652,0.00816491,0.00544997,0.00213172,-0.00178984,-0.00028155,0.00364002,0.00695827,0.00967320,0.01178482,0.01329311,0.01419809,0.01449975,0.01419809,0.01329311,0.01178482,0.00967320,0.00695827,0.00364002,-0.00028155,0.00062343,0.00454500,0.00786325,0.01057818,0.01268979,0.01419809,0.01510307,0.01540473,0.01510307,0.01419809,0.01268979,0.01057818,0.00786325,0.00454500,0.00062343,0.00092509,0.00484666,0.00816491,0.01087984,0.01299145,0.01449975,0.01540473,0.01570639,0.01540473,0.01449975,0.01299145,0.01087984,0.00816491,0.00484666,0.00092509,0.00062343,0.00454500,0.00786325,0.01057818,0.01268979,0.01419809,0.01510307,0.01540473,0.01510307,0.01419809,0.01268979,0.01057818,0.00786325,0.00454500,0.00062343,-0.00028155,0.00364002,0.00695827,0.00967320,0.01178482,0.01329311,0.01419809,0.01449975,0.01419809,0.01329311,0.01178482,0.00967320,0.00695827,0.00364002,-0.00028155,-0.00178984,0.00213172,0.00544997,0.00816491,0.01027652,0.01178482,0.01268979,0.01299145,0.01268979,0.01178482,0.01027652,0.00816491,0.00544997,0.00213172,-0.00178984,-0.00390146,0.00002011,0.00333836,0.00605329,0.00816491,0.00967320,0.01057818,0.01087984,0.01057818,0.00967320,0.00816491,0.00605329,0.00333836,0.00002011,-0.00390146,-0.00661639,-0.00269482,0.00062343,0.00333836,0.00544997,0.00695827,0.00786325,0.00816491,0.00786325,0.00695827,0.00544997,0.00333836,0.00062343,-0.00269482,-0.00661639,-0.00993464,-0.00601307,-0.00269482,0.00002011,0.00213172,0.00364002,0.00454500,0.00484666,0.00454500,0.00364002,0.00213172,0.00002011,-0.00269482,-0.00601307,-0.00993464,-0.01385621,-0.00993464,-0.00661639,-0.00390146,-0.00178984,-0.00028155,0.00062343,0.00092509,0.00062343,-0.00028155,-0.00178984,-0.00390146,-0.00661639,-0.00993464,-0.01385621];
    C = vec2mat(C,15);
end;

if(display)
    f1=figure;
    f2=figure;
    f3=figure;
    f4=figure;
end;

if 0
    fprintf(1,'Smoothing image using Savitzky-Golay filter, patchwidth %d\n',pw);
end
b = zeros(size(a));
% this is where it is checked that the values are non-negative
ind = find(a>=0);
for ix=1:size(C,2)
    for iy=1:size(C,1)
        a1 = shiftimg(a,ix-(size(C,2)+1)/2,iy-(size(C,1)+1)/2);
        if(display)
            figure(f1);
            subplot(size(C,1),size(C,2),(ix-1)*size(C,2)+iy);
            imshow(a1,cs);
            title(['Shift by [',num2str(ix-(size(C,2)+1)/2),',',num2str(iy-(size(C,1)+1)/2),']']);
        end;
        if(display)
            figure(f2);
            subplot(size(C,1),size(C,2),(ix-1)*size(C,2)+iy);
            imshow(C(iy,ix)*a1/max(max(C)),cs);
            %title(['Shift by [',num2str(ix-(size(C,2)+1)/2),',',num2str(iy-(size(C,1)+1)/2),']']);
        end;            
        b(ind) = b(ind) + C(iy,ix) * a1(ind);
    end;
    %disp([num2str(ceil(ix/size(C,2)*100)),'% done']);
end;

% take only the central image (corresponding to the original)
if 1
    b = b([1:size(ao,1)]+size(ao,1),[1:size(ao,2)]+size(ao,2));
end;

if(display)
    figure(f3);
    imshow(a,cs); title('Original');
    figure(f4);
    imshow(b,cs); title('Smoothed');
end;

% finally add the offset
b = b+mina;

% finally cut off values <mina or >maxa
ind=find(b<mina);
b(ind)=mina;
ind=find(b>maxa);
b(ind)=maxa;


function mat = vec2mat(vec, m)
% Convert a 1-d vector into a matrix (written by Libi Hertzberg) 
n = (length(vec))/m;
mat = (reshape(vec, m, n));
