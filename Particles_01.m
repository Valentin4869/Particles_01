v1=[0,0]; %position vector for v1

N=30;
P=randn(N,2)*100; %position matrix
V=randn(N,2)*30 %velocity matrix
A=zeros(N,2);
A(:,2)=-10.0;
V(1,:)=[-10 0]

P(1,:)=[100 0];
P(2,:)=P(1,:)+[-50 0]



t=0.0 %time
dt= 0.02 %delta t
eC=0.7;

hPlot = plot( P(:,1), P(:,2), 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 6,...
	'MarkerEdgeColor', 'k');


axis([-300 300 -300 300])
caxis=axis;
set(gcf, 'UserData', true);


lim=1.5

while get(gcf, 'UserData')
    
    %r = roots(p(t));
    %r = 2*rand(1,1);
    
    %update v
    for i=1:N
       
           F=0.0;
         
            %wall
            if P(i,1)<caxis(1,1)
                P(i,1)=caxis(1,1)+5;
                V(i,1)=V(i,1)*-eC;
            elseif P(i,1)>caxis(1,2)
                P(i,1)=caxis(1,2)-5;
                V(i,1)=V(i,1)*-eC;
            elseif P(i,2)<caxis(1,3)
                P(i,2)=caxis(1,3)+5;
                V(i,2)=V(i,2)*-eC;
            elseif P(i,2)>caxis(1,4)
                P(i,2)=caxis(1,4)-5;
                V(i,2)=V(i,2)*-eC;
                        
            end
            
            
            
          for j=1:N
                if j==i
                    continue;
                end
            NORMAL=(P(i,:)-P(j,:));
            d=norm(NORMAL);
            
            
            if  d<=12
                 NORMAL=NORMAL/d; %get contact normal
                 %sepV=dot(V(i,:)-V(j,:))*-0.56;
                 diff=(12.0-d)/2.0;
                 diff1=diff*V(i,:)/(V(i,:)+V(j,:));
                 diff2=diff*V(j,:)/(V(i,:)+V(j,:));
                 
                 P(i,:)=P(i,:) +NORMAL*diff1;
                 P(j,:)=P(j,:) - NORMAL*diff2;
                 
                 V(i,:)=V(i,:)+NORMAL*0.99;
                 V(j,:)=V(j,:)-NORMAL*0.99;
                
                
            end
            
          end
        
    end

    
    %next time step
    V=V+A*dt;
    P=P+V*dt;
    
   
%    hAxes=gca;
%    hhx= get(hAxes, 'XLim');
%    hhy= get(hAxes, 'YLim');
%    
%    %resize axis
%    if (v1(1)<hhx(1) || v1(1)>hhx(2)) || (v1(2)<hhy(1) || v1(2)>hhy(2))
%       set(hAxes,'XLim', lim.*hhx);
%        
%      set(hAxes,'YLim', lim.*hhy);
%        
%    
%    end

   
   set(hPlot, 'XData', P(:,1), 'YData', P(:,2));
     title(num2str(t));
    
  
    drawnow;
   
 
end



%--------------------------
