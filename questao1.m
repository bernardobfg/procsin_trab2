% Carregar o sinal de voz
[voz, fs_voz] = audioread('voz.mpeg'); % Substitua 'voz.mpeg' pelo nome do arquivo que contém o sinal de voz

% Carregar o sinal de música no formato .mpeg
[musica, fs_musica] = audioread('musica.mpeg'); % Substitua 'musica.mpeg' pelo nome do arquivo que contém o sinal de música

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

% Configurações do espectrograma
window_size = round(0.03 * fs_target); % Tamanho da janela (aproximadamente 30 ms)
overlap = round(window_size * 0.5); % Sobreposição entre janelas (50%)
nfft = 2^nextpow2(window_size); % Tamanho da FFT (potência de 2)

% Calcular o eixo x em número de amostras
num_amostras = size(voz_resampled, 1);
eixo_x = (0:num_amostras-1)';

% Espectrograma do sinal de voz reamostrado
figure;
spectrogram(voz_resampled, hamming(window_size), overlap, nfft, fs_target, 'yaxis');
set(gca, 'XTick', linspace(0, num_amostras, 5), 'XTickLabel', linspace(0, num_amostras, 5));
xlabel('Número de Amostras');
title('Espectrograma do Sinal de Voz (Reamostrado)');
colorbar;

% Espectrograma do sinal de música reamostrado
figure;
spectrogram(musica_resampled, hamming(window_size), overlap, nfft, fs_target, 'yaxis');
set(gca, 'XTick', linspace(0, num_amostras, 5), 'XTickLabel', linspace(0, num_amostras, 5));
xlabel('Número de Amostras');
title('Espectrograma do Sinal de Música (Reamostrado)');
colorbar;
