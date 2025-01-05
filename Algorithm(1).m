% 最优防御策略选择算法

% 假设参数
n = 5; % 攻击策略数量
m = 5; % 防御策略数量
lambda1 = 0.5; % 攻击者理性参数
lambda2 = 0.5; % 防御者理性参数

% 初始化策略集和信念集
P = ones(1, n) / n; % 攻击信念集，初始均匀分布
Q = ones(1, m) / m; % 防御信念集，初始均匀分布

% 攻击和防御的收益矩阵（需要数据集，因此这里给出一个基本框架）
AB = rand(n, m); % 攻击收益
AC = rand(n, m); % 攻击成本
DB = rand(n, m); % 防御收益
DC = rand(n, m); % 防御成本
aij = AB - AC;
dij = DB - DC;

% 迭代计算进化稳定均衡点
maxIter = 1000; % 最大迭代次数
tolerance = 1e-4; % 收敛容忍度
for iter = 1:maxIter
    % 更新攻击策略
    F_pi = zeros(1, n);
    for i = 1:n
        F_pi(i) = exp(lambda1 * sum(Q .* aij(i, :))) / sum(exp(lambda1 * sum(Q .* aij, 2)));
    end
    
    % 更新防御策略
    G_qj = zeros(1, m);
    for j = 1:m
        G_qj(j) = exp(lambda2 * sum(P .* dij(:, j)')) / sum(exp(lambda2 * sum(P .* dij, 1)));
    end
    
    % 检查是否收敛到进化稳定均衡点
    Y = norm([F_pi - P, G_qj - Q]);
    if Y < tolerance
        break;
    end

    P = F_pi;
    Q = G_qj;
end

% 输出最优防御策略
optimalDefenseStrategy = Q;
disp('最优防御策略:');
disp(optimalDefenseStrategy);
