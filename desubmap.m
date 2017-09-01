function r=desubmap(x,map,FFTsize)
r=zeros(1,FFTsize);
if map=='Interleaved'
q=length(x)/FFTsize;
r(1:end)=x(1:q:end);
end
end