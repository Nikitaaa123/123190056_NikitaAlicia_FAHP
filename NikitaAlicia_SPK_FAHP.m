namaPemain = {'Bagas' 'Bagus' 'Witan' 'Egi'};
data = [ 34 30 28  
         30 43 24
         29 49 27
         47 55 40];
     
%batas kriteria     
maksJumlahPertandingan = 50;
maksCetakGol = 60;
maksJumlahMenang = 50;

data(:,1) = data(:,1) / maksJumlahPertandingan;
data(:,2) = data(:,2) / maksCetakGol;
data(:,3) = data(:,3) / maksJumlahMenang;

relasiAntarKriteria = [ 1     2     2
                        0     1     4
                        0     0     1];
                    
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};

[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)

if RasioKonsistensi < 0.10
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria';
    disp('==== Hasil Perhitungan dengan metode Fuzzy AHP ====')
    disp('+----------------+--------------+----------------+')
    disp('|   Nama Pemain  |  Skor Akhir  |   Kesimpulan   |')
    disp('+----------------+--------------+----------------+')
end

for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Tim D';
        elseif ahp(i) < 0.7
            status = 'Tim C';
        elseif ahp(i) < 0.8
            status = 'Tim B';
        else
            status = 'Tim A';
        end
        
        disp(['| ', char(namaPemain(i)), blanks(15 - cellfun('length',namaPemain(i))), '| ', ... 
             num2str(ahp(i)), blanks(13 - length(num2str(ahp(i)))), '| ', ...
             char(status), blanks(15 - length(num2str(status))) '| '])
end
    disp('+----------------+--------------+----------------+')