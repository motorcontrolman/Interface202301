close all;
K = [0.1, 1, 10];

Freq = logspace(-1, 2, 100).';
w = 2 * pi * Freq;

%% 積分要素、比例要素、微分要素の順に描画
for ii = -1:1
    figure();
    for jj = 1:length(K)
        Gs = K(jj) * s ^ ii;                        % 伝達関数の定義
        [Mag, Phase] = bode(Gs, w);                 % ゲイン、位相の算出
        Gain = 20 * log10( reshape(Mag, [], 1) );   % ゲインデータ成形および単位変換
        Phase = reshape(Phase, [], 1);              % 位相データの成形
        
        legendTxt = "K=" + num2str(K(jj));          % 凡例の記載内容を定義
        
        % ゲイン線図を描画
        sp1 = subplot(2,1,1);
        sl = semilogx(Freq, Gain, 'DisplayName', legendTxt);
        sl.LineWidth = 2;
        hold on; grid on; legend;
        axis([0.1, 100, -60, 60]);
        xlabel("周波数[Hz]");
        ylabel("ゲイン[dB]");
        
        % 位相線図を描画
        sp2 = subplot(2,1,2);
        sl = semilogx(Freq, Phase, 'DisplayName', legendTxt);
        sl.LineWidth = 2;
        hold on; grid on; legend;
        axis([0.1, 100, -120, 120]);
        yticks(-120: 30: 120);
        xlabel("周波数[Hz]");
        ylabel("位相[°]");
    end
    sp1.FontSize = 9;
    sp2.FontSize = 9;
end

