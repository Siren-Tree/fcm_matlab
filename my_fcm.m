function [center, U,J]=my_fcm(data,cluster_n,m)
% data���ݼ�,cluster_n����,mģ��ֵ
    % ��ʼ��U��U��СΪcluster_n*data��Ԫ�صĸ���
    U = rand(cluster_n,size(data,1));
    col_sum = sum(U);
    U = U./col_sum(ones(cluster_n, 1), :);
    
    for iter=1:100
        % ����Cֵ��C��СΪcluster_n*data��ά��
        center=U.^(m)*data./sum(U.^(m),2);
        
        % ����Uֵ
        temp=ones(size(U));
        for k = 1:cluster_n
            % Uֵ��ά�����޹أ�����||X-C||��ʽ���ǽ�ά�Ⱥϲ�������Ҫ�ڴ˴���һ����ά����
            % ����õ�ƽ���ͣ����ٿ��������������Ͳ����ٲ��� .^(2/(m-1))������.^(m-1)
            temp(k,:)=sum((data-center(ones(size(data,1),1)*k,:)).^2,2);
        end
        % temp��¼ָ��Ϊ2�Ľ�����������ں�����Ŀ�꺯�����㻹���õ�
        % temp_m��¼ָ��Ϊ2/(m-1)�Ľ������������U�ļ�������Ҫ
        temp_m=1./(temp.^(1/(m-1)));
        temp_sum=sum(temp_m,1);
        U=temp_m./temp_sum;

        % ����Ŀ�꺯��
        J_new=sum(sum((U.^m).*temp));
        format long;
        fprintf('��������Ϊ��%d, Ŀ�꺯��Ϊ��%f\n', iter, J_new);
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