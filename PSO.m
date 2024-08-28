function [g_best, f_gbest] = PSO(prob,lb,ub,Np,T)


D = length(lb);
p = repmat(lb,Np,1)+(ub-lb).*rand(Np,D);
v = repmat(lb,Np,1)+(ub-lb).*rand(Np,D);

f = NaN(Np,1);

for i = 1:Np
f(i) = prob(p(i,:));
end


p_best = p;
f_pbest = f;

[f_gbest,ind] = min(f);
g_best = p(ind,:);

for t = 1:T
    for i = 1:Np
        v(i,:) = 0.7.*v(i,:) + 1.5.*rand(1,D).*(p_best(i,:)-p(i,:)) + 1.5.*rand(1,D).*(g_best-p(i,:));
        p(i,:) = p(i,:)+v(i,:);

        fn = prob(p(i,:));
        if fn<f_pbest(i)
            p_best(i,:) = p(i,:);
            f_pbest(i) = fn;

        if fn<f_gbest
            g_best = p(i,:);
            f_gbest = fn;
        end
        end
    end
end

