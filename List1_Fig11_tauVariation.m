clear;
close all;
s = tf('s');    % ラプラス演算子を定義
K = 1;          % １次遅れ系のゲイン

tau1 = 0.1;             % 時定数0.1(s)
Gs1 = K / (tau1*s + 1); % 伝達関数1の定義

tau2 = 0.05;             % 時定数0.05(s)
Gs2 = K / (tau2*s + 1); % 伝達関数2の定義

tau3 = 0.02;             % 時定数0.01(s)
Gs3 = K / (tau3*s + 1); % 伝達関数3の定義


% 伝達関数1～3のステップ応答を表示
drawCurCtrlReq;
t = 0: 0.001: 0.4;
[y1] = step(Gs1, t);
[y2] = step(Gs2, t);
[y3] = step(Gs3, t);
plot(t, y1, 'LineWidth',2);
plot(t, y2, 'LineWidth',2);
plot(t, y3, 'LineWidth',2);

grid on;
axis([0, 0.4, 0, 1.1]);
legend('Req1', 'Req2', 'Req2', 'Req3', ...
    '\tau=0.1s', '\tau=0.05s', '\tau=0.02s'); % 凡例の表示
