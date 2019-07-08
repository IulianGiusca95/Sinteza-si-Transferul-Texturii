function d = aflaDrum(E)

d = zeros(size(E,1),2);

 M = zeros (size(E));
 M(1,:) = E(1,:);
        for i = 2 : size(E,1)
            for j = 1: size(E,2)
                if(j == 1) && size(E,2) == 1
                    M(i,j) = E(i,j) + M(i-1,j);
                elseif (j==1)
                    M(i,j) = E(i,j) + min(M(i-1,j),M(i-1,j+1));
                elseif(j == size(E,2))
                    M(i,j) = E(i,j) + min(M(i-1,size(E,2)),M(i-1,size(E,2)-1));
                else
                    M(i,j) = E(i,j) + min( M(i-1,j) , min( M(i-1,j-1)  , M(i-1,j+1) ));
                end
            end
        end
   
        minVal = min(M(size(E,1),:));
        for i = 1 : size(E,2)
           if M(size(E,1),i)==minVal
               break;
           end
        end
        coloana = i;
        linia = size(E,1);
        
        d(linia,:)= [linia coloana];
        
        for i = size(E,1)-1 : -1 : 1
            
            if size(E,2) == 1
                for j = 1:size(d,1)-1
                    d(j,:) = [j coloana];
                end
                break;
            end
           if d(i+1,2)==1
               if M(i,1) < M(i,2)
                   
                   d(i,:)=[i 1];
               else
                   
                   d(i,:)=[i 2];
               end
           elseif d(i+1,2) ==size(E,2)
               if M(i,size(E,2)) < M(i,size(E,2)-1)
                   d(i,:) = [i size(E,2)];
                  
               else
                   d(i,:) = [i size(E,2)-1];
                 
               end
           elseif M(i,d(i+1,2)+1) < M(i,d(i+1,2)) && M(i,d(i+1,2)+1) < M(i,d(i+1,2)-1)
                   d(i,:) = [i d(i+1,2)+1];
                  
           elseif M(i,d(i+1,2)-1) < M(i,d(i+1,2)+1) && M(i,d(i+1,2)-1) < M(i,d(i+1,2))
                   d(i,:) = [i d(i+1,2)-1];
                  
           else
                   d(i,:) = [i d(i+1,2)];
                  
               end
           end
end

