% Especificações do filtro
passband_ripple = 0.02; % Ripple na banda de passagem (em módulo)
stopband_ripple = 0.15; % Ripple na banda de rejeição (em módulo)
passband_freq = 0.63; % Frequência limite da banda de passagem (normalizada)
stopband_freq = 0.65; % Frequência limite da banda de rejeição (normalizada)

% Frequência de amostragem
fs = 16000; % Substitua pelo valor correto da frequência de amostragem em Hz

% Projeto do filtro IIR usando Chebyshev Tipo I
n = 4; % Ordem do filtro
[b, a] = cheby1(n, passband_ripple, passband_freq, 'low'); % Filtro IIR de Chebyshev Tipo I

% Plotar o diagrama de polos e zeros
figure;
zplane(b, a);
title('Diagrama de Polos e Zeros (IIR - Chebyshev Tipo I)');

% Calcular a resposta em frequência
[h, w] = freqz(b, a, 1024);
frequencies = w * fs / (2*pi); % Frequências em Hz

% Plotar a resposta em frequência
figure;
plot(frequencies, abs(h));
title('Resposta em Frequência (IIR - Chebyshev Tipo I)');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% Ajustar os limites do eixo y
ylim([-0.3, 1.3]);
