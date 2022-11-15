clear;
close all;
s = tf('s');

%% １次遅れ系のバリエーションを定義
%　伝達関数は G(s) = K/(tau*s + a0) を前提とする。
%　a0は本来１固定だが、積分要素も含めて一元管理する目的で変数として扱う。
K =     [1;     1;      1;      1;      1];
tau =   [0;     1.6;    0.16;   1.6;    0.16;];
a0 =    [1;     0;      0;      1;      1;];

%% 線の種類や色、凡例を定義
bLineWidth = [1; 1; 1; 2; 2];
bColor = [
    [0 0 0];
    [0 0 0];
    [0.5 0.5 0.5];
    [1 0.5 0.7];
    [1 0 0]
    ];

% 凡例の記載内容を定義
bLineStyle = ["-."; "--"; ":"; "-"; "-"];
bDisplayName = "K="+ num2str(K) + ", \tau=" + num2str(tau) + ", a=" + num2str(a0) + ...
    ["(比例要素)"; "(積分要素)"; "(積分要素)"; ""; ""];   

bodeInfo = table(K, tau, a0, bLineWidth, bColor, bLineStyle, bDisplayName);

% ボード線図描画時の周波数設定
Freq = logspace(-3, 2, 100).';
w = 2 * pi * Freq;

%% ボード線図描画
for jj = 1:height(bodeInfo)
    Ps = bodeInfo.K(jj)/(bodeInfo.tau(jj) * s + bodeInfo.a0(jj));   % 伝達関数の定義
    [Mag, Phase] = bode(Ps, w);                                     % ゲイン、位相の算出
    Gain = 20 * log10( reshape(Mag, [], 1) );                       % ゲインデータ成形および単位変換
    Phase = reshape(Phase, [], 1);                                  % 位相データの成形
    
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
