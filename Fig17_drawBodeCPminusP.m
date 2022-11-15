clear;
close all;

%% 伝達関数の定義
% RL回路の伝達関数
s = tf('s');
R = 0.1;        % 巻線抵抗(Ω)
L = 4e-3;       % インダクタンス(H)
Ps = 1/(L*s + R);

% 規範モデルの伝達関数
tau = 0.02; % 時定数0.02(s)
CsPs = 1/(tau * s);

% モデルマッチングにより導出した制御器の伝達関数(規範モデル：１次遅れ)
Kp = L/tau;    % Pゲイン
Ki = R/tau;    % Iゲイン
Cs = (s*Kp + Ki)/s;

%% ボード線図描画の前準備
% 線の種類や色の設定
bLineWidth = [2; 2; 2; 2];
bLineStyle = ["-"; "-"; "-";"--"];
bColor = [
    [1 0 1];
    [1 0 0];
    [0 0 1];
    [0.5 0.7 1]];

% 凡例記載内容
bDisplayName = [
    "CsPs=1/(\tau s)";
    "Ps=1/(Ls+R)";
    "CsPs-Ps"
    "PI制御器(Kp=L/\tau,Ki=R/\tau)"];

% 上記設定をtable型としてまとめておく
bodeInfo = table(bLineWidth, bColor, bLineStyle, bDisplayName);

% ボード線図描画時の周波数設定
Freq = logspace(-3, 3, 100).';
w = 2 * pi * Freq;

%% ボード線図描画
% 注：位相、ゲイン結果はそれぞれ Gains, Phases にまとめている。

% C(s)P(s)
[Mag, Phase] = bode(CsPs, w);                           % ゲイン、位相の算出
Gains = 20 * log10( reshape(Mag, [], 1) );              % ゲインデータ成形および単位変換
Phases = reshape(Phase, [], 1);                         % 位相データの成形

% P(s)
[Mag, Phase] = bode(Ps, w);
Gains = [Gains, 20 * log10( reshape(Mag, [], 1) )]; 
Phases = [Phases, reshape(Phase, [], 1)];

% C(s)P(s) - P(s)
Gains = [Gains, Gains(:,1) - Gains(:,2)];
Phases = [Phases, Phases(:,1) - Phases(:,2)];

% モデルマッチングによって求めたC(s)
[Mag, Phase] = bode(Cs, w);
Gains = [Gains, 20 * log10( reshape(Mag, [], 1) )];
Phases = [Phases, reshape(Phase, [], 1)];  

for jj = 1:height(bodeInfo)
    % ゲイン線図を描画
    sp1 = subplot(2,1,1);
    sl = semilogx(Freq, Gains(:,jj));
    sl.LineWidth = bodeInfo.bLineWidth(jj);
    sl.Color = bodeInfo.bColor(jj, :);
    sl.LineStyle = bodeInfo.bLineStyle(jj);
    sl.DisplayName = bodeInfo.bDisplayName(jj);


    hold on; grid on; legend;
    axis([0.1, 1000, -40, 40]);
    xlabel("周波数[Hz]");
    ylabel("ゲイン[dB]");
    
    % 位相線図を描画
    sp2 = subplot(2,1,2);
    sl = semilogx(Freq, Phases(:,jj));
    sl.LineWidth = bodeInfo.bLineWidth(jj);
    sl.Color = bodeInfo.bColor(jj, :);
    sl.LineStyle = bodeInfo.bLineStyle(jj);
    sl.DisplayName = bodeInfo.bDisplayName(jj);

    hold on; grid on; legend;
    axis([0.1, 1000, -120, 30]);
    yticks(-120: 30: 30);
    xlabel("周波数[Hz]");
    ylabel("位相[°]");
end

sp1.FontSize = 9;
sp2.FontSize = 9;
