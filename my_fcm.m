function [center, U,J]=my_fcm(data,cluster_n,m)
% data数据集,cluster_n簇数,m模糊值
    % 初始化U，U大小为cluster_n*data中元素的个数
    U = rand(cluster_n,size(data,1));
    col_sum = sum(U);
    U = U./col_sum(ones(cluster_n, 1), :);
    
    for iter=1:100
        % 计算C值，C大小为cluster_n*data的维数
        center=U.^(m)*data./sum(U.^(m),2);
        
        % 计算U值
        temp=ones(size(U));
        for k = 1:cluster_n
            % U值与维度数无关，所以||X-C||的式子是将维度合并，不需要在此创建一个三维数据
            % 计算得到平方和，不再开方，后续操作就不用再补充 .^(2/(m-1))，而是.^(m-1)
            temp(k,:)=sum((data-center(ones(size(data,1),1)*k,:)).^2,2);
        end
        % temp记录指数为2的结果，这个结果在后续的目标函数计算还需用到
        % temp_m记录指数为2/(m-1)的结果，这个结果在U的计算中需要
        temp_m=1./(temp.^(1/(m-1)));
        temp_sum=sum(temp_m,1);
        U=temp_m./temp_sum;

        % 计算目标函数
        J_new=sum(sum((U.^m).*temp));
        format long;
        fprintf('迭代次数为：%d, 目标函数为：%f\n', iter, J_new);
        if exist('J','var')==0
            J=J_new;
        elseif(abs(J-J_new)<1e-5)
            J=J_new;
            break;
        else
            J=J_new;
        end
    end 
end