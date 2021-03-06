clear, clc;
M = 3;% = 5 % ���������� ��������� ������� (����� ��������)
N = 16 % = 10; % ���������� ������� (����� �������)
Q = 10000; % ���������� �������������
r = 120; % ���������� �������� ��� ��������� (��. hist)

L = zeros (Q, 1);
L_abs = zeros (Q, 1);
L_real = zeros (Q, 1);

for q = 1:1:Q
    A = zeros (M, M);
    for n = 1:1:N
        x = randn(M, 1);
        y = randn(M, 1);
        z = x+i*y; % ����������� ��������� ��� ��� ������ �������(������-�������)
        Z_tr = z'; % ����������������� ������ z (������-������)
        P = z*Z_tr; % ������������ �������-������� �� ������-������
        % ��������� - ������� M x M
        A = A + P; % ������� � (��������� �������� ���� ������������ �)
        % ��������� - ������� M x M
    end

    % ������� �������������� �������
    B = A ./ N;
    % disp ('�������������� �������:');
    % disp (B);

    % ������� ��������� Ch ��� GLR-����������
    D = det(A); % ��������� ����������� ������� �
    Ch = D.^N;

    % ������� ����������� ��� GLR-����������
    Pm = 1;
    for i = 1:1:M
        Pm = Pm .* ((A(i,i)).^N);
    end
    % disp (Pm);

    % ��������� GLR-����������
    GLR = Ch ./ Pm;
    % disp ('�������� ��������� �������������:');
    % disp (GLR);

    % ������� ������ ���������� ��� Q �������������
    L (q,1) = GLR;
    %  disp (L);
    
    % ��������� � ������������� ������������� ������ ����������
    GLR_abs = abs(GLR);
    L_abs (q,1) = GLR_abs;
    
    % ��������� � ������������� ������������� �������� ����� ����������
    % GLR_real = real(GLR);
    % L_real (q,1) = GLR_real;
    
end

t = 1:1:Q;
[m t] = hist(L_abs,r);
w = m/(Q*(t(2)-t(1))); % ���
f = cumsum(m/Q); % ������������ ���

figure
plot (t, w, t, f);
title ('������ ��� � ������������ ���');
legend ('PDF', 'CDF');
grid on;

figure
plot (t, w);
xlabel ('��������� �������������');
ylabel ('���');
title ('������ ������� ��������� �����������');
grid on;

figure
plot (t, f);
xlabel ('��������� �������������');
ylabel ('������������ ���');
title ('������ ������������ ������� ��������� �����������');
grid on;

figure
plot (L_abs);
xlabel ('����� ������������');
ylabel ('�������� ��������� �������������');
title ('������ ��������� �������������');
grid on;

% figure
% plot (L_real);
% grid on;