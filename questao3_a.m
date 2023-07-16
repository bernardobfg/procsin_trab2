% Especificações do filtro
passband_ripple = 0.02; % Ripple na banda de passagem (em módulo)
stopband_ripple = 0.15; % Ripple na banda de rejeição (em módulo)
passband_freq = 0.63; % Frequência limite da banda de passagem (normalizada)
stopband_freq = 0.65; % Frequência limite da banda de rejeição (normalizada)

% Projeto do filtro FIR usando Parks-McClellan
forder = 84;
frequencies = [0, passband_freq, stopband_freq, 1]; % Vetor de frequências normalizadas
magnitudes = [1, 1, 0, 0]; % Vetor de magnitudes
weights = [1/passband_ripple, 1/stopband_ripple]; % Vetor de pesos

% Projeto do filtro FIR usando Parks-McClellan
fir_coeffs = firpm(forder, frequencies, magnitudes, weights);

% Plotar o diagrama de polos e zeros
figure;
zplane(fir_coeffs, 1);
title('Diagrama de Polos e Zeros (FIR - Parks-McClellan)');

% Calcular a resposta em frequência
freq_response = freqz(fir_coeffs, 1);

% Plotar a resposta em frequência
figure;
plot(linspace(0, 1, length(freq_response)), abs(freq_response));
title('Resposta em Frequência (FIR - Parks-McClellan)');
xlabel('Frequência Normalizada');
ylabel('Magnitude');
