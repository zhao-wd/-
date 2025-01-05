% 定义函数 f 和 g
f = @(p, q, lambd) exp(lambd * (-30 * q - 10)) ./ (exp(lambd * (-30 * q - 10)) + exp(lambd * (-5 * q - 15))) - p;
g = @(p, q, lambd) exp(lambd * (-50 * p - 10)) ./ (exp(lambd * (-50 * p - 10)) + exp(lambd * (25 * p - 30))) - q;

% 初始化参数
lambd = 1;
p = linspace(0, 1, 200);
q = linspace(0, 1, 200);

% 初始化矩阵 F 和 G
F = zeros(length(p), length(q));
G = zeros(length(p), length(q));

% 计算 F 和 G 的值
for i = 1:length(p)
    for j = 1:length(q)
        F(j, i) = f(p(i), q(j), lambd);
        G(j, i) = g(p(i), q(j), lambd);
    end
end

% 绘图
figure;
hold on;

% 创建等高线
[Cp, hp] = contour(p, q, F, [0 0], 'b--');
[Cq, hq] = contour(p, q, G, [0 0], 'r--');

% 计算交点
[xi, yi] = polyxpoly(Cp(1, 2:end), Cp(2, 2:end), Cq(1, 2:end), Cq(2, 2:end));

% 绘制交点
plot(xi, yi, 'ko', 'MarkerFaceColor', 'k');

% 标记交点坐标
for k = 1:length(xi)
    text(xi(k), yi(k), sprintf('(%.4f, %.4f)', xi(k), yi(k)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

% 设置标签和标题
xlabel('p');
ylabel('q');
title('双方的演化曲线');

% 显示网格
grid on;
hold off;
