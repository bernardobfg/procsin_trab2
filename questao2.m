% Carregar o sinal de voz
[voz, fs_voz] = audioread('voz.mpeg');

% Carregar o sinal de música no formato .mpeg
[musica, fs_musica] = audioread('musica.mpeg');

% Frequência de amostragem desejada
fs_target = 16000;

% Início e duração desejados em segundos
inicio_segundos = 10;
duracao_segundos = 5;

% Converter início e duração para amostras
inicio_amostras = round(inicio_segundos * fs_target) + 1;
duracao_amostras = round(duracao_segundos * fs_target);

% Ajustar o tamanho da voz
voz_inicio = voz(inicio_amostras : inicio_amostras + duracao_amostras - 1);

% Ajustar o tamanho da música
musica_inicio = musica(inicio_amostras : inicio_amostras + duracao_amostras - 1);

% Reamostrar os sinais para 16 kHz
voz_resampled = resample(voz_inicio, fs_target, fs_voz);
musica_resampled = resample(musica_inicio, fs_target, fs_musica);

% Relação sinal-ruído desejada em dB
snr_dB = 10; % SNR desejada em dB

% Calcular a potência do sinal original
potencia_original_voz = sum(voz_resampled.^2) / length(voz_resampled);
potencia_original_musica = sum(musica_resampled.^2) / length(musica_resampled);

% Calcular a potência do ruído
snr_linear = 10^(snr_dB/10);
variancia_ruido_voz = potencia_original_voz / snr_linear;
variancia_ruido_musica = potencia_original_musica / snr_linear;

% Gerar ruído branco para adicionar ao sinal de voz
ruido_voz = sqrt(variancia_ruido_voz) * randn(size(voz_resampled));

% Gerar ruído branco para adicionar ao sinal de música
ruido_musica = sqrt(variancia_ruido_musica) * randn(size(musica_resampled));

% Adicionar ruído aos sinais
voz_ruidosa = voz_resampled + ruido_voz;
musica_ruidosa = musica_resampled + ruido_musica;

% Configurações do espectrograma
window_size = round(0.03 * fs_target); % Tamanho da janela (aproximadamente 30 ms)
overlap = round(window_size * 0.5); % Sobreposição entre janelas (50%)
nfft = 2^nextpow2(window_size); % Tamanho da FFT (potência de 2)

% Espectrograma do sinal de voz ruidoso
figure;
spectrogram(voz_ruidosa, hamming(window_size), overlap, nfft, fs_target, 'yaxis');
title('Espectrograma do Sinal de Voz Ruidoso');
colorbar;

% Espectrograma do sinal de música ruidoso
figure;
spectrogram(musica_ruidosa, hamming(window_size), overlap, nfft, fs_target, 'yaxis');
title('Espectrograma do Sinal de Música Ruidoso');
colorbar;
