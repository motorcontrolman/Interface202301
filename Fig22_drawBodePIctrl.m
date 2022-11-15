clear;
close all;
s = tf('s');

%% Kp,Kiのバリエーションを定義
Ki = [0.1;  0;      0;      0.1; 0.1];
Kp = [0;    0.01;   0.1;    0.1; 0.01];

%% 線の種類や色、凡例を定義
bLineWidth = [1; 1; 1; 2; 2];
bColor = [
    [0 0 0];
    [0 0 0];
    [0.5 0.5 0.5];
    [0.5 0.7 1];
    [0 0 1]
    ];

bLineStyle = ["-."; "--"; ":"; "-"; "-"];
bDisplayName = "Kp="+ num2str(Kp) + ", Ki=" + num2str(Ki) + ...
    ["(積分要素)"; "(比例要素)"; "(比例要素)"; ""; ""];   % 凡例の記載内容を定義

bodeInfo = table(Kp, Ki, bLineWidth, bColor, bLineStyle, bDisplayName);

% ボード線図描画時の周波数設定
Freq = logspace(-3, 2, 100).';
w = 2 * pi * Freq;

%% ボード線図描画
for jj = 1:height(bodeInfo)
    Cs = (s * bodeInfo.Kp(jj) + bodeInfo.Ki(jj))/s;         % 伝達関数の定義
    [Mag, Phase] = bode(Cs, w);                             % ゲイン、位相の算出
    Gain = 20 * log10( reshape(Mag, [], 1) );               % ゲインデータ成形および単位変換
    Phase = reshape(Phase, [], 1);                          % 位相データの成形
    
    % ゲイン線図を描画
    sp1 = subplot(2,1,1);                             
    sl = semilogx(Freq, Gain);
    sl.LineWidth = bodeInfo.bLineWidth(jj);
    sl.Color = bodeInfo.bColor(jj, :);
    sl.LineStyle = bodeInfo.bLineStyle(jj);
    sl.DisplayName = bodeInfo.bDisplayName(jj);


    hold on; grid on; legend;
    axis([0.01, 100, -50, 10]);
    xlabel("周波数[Hz]");
    ylabel("ゲイン[dB]");
    
    % 位相線図を描画
    sp2 = subplot(2,1,2);
    sl = semilogx(Freq, Phase);
    sl.LineWidth = bodeInfo.bLineWidth(jj);
    sl.Color = bodeInfo.bColor(jj, :);
    sl.LineStyle = bodeInfo.bLineStyle(jj);
    sl.DisplayName = bodeInfo.bDisplayName(jj);

    hold on; grid on; legend;
    axis([0.01, 100, -120, 30]);
    yticks(-120: 30: 120);
    xlabel("周波数[Hz]");
    ylabel("位相[°]");
end

sp1.FontSize = 9;
sp2.FontSize = 9;
