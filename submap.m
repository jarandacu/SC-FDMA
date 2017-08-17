function r=submap(x,map,Nsub)
r=zeros(1,Nsub);
if map=='Interleaved'
q=Nsub/length(x);
r(1:q:Nsub)=x;
end
end