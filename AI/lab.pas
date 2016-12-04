program LABIRINTAS; {Kelio paieška algoritmu BACKTRACK1, t. y. į gylį}
uses Crt;
const M = 4; N = 4; {Labirinto matmenys}
var LAB : array[1..M, 1..N] of integer; {Labirintas}
 CX, CY : array[1..4] of integer; {4 produkcijos - X ir Y poslinkiai}
 L, {Ėjimo eilės numeris pradedant nuo 2. Žymi aplankytą langelį}
 X, Y, {Pradinė agento padėtis}
 I, J, {Ciklo kintamieji}
 BANDSK : integer; {Bandymų skaičius. Dėl efektyvumo palyginimo}
 YRA : boolean; {Ar kelias egzistuoja}
procedure EITI(X, Y : integer; var YRA : boolean);
 var K, {Einamosios produkcijos numeris}
 U, V : integer; {Nauja padėtis pritaikius produkciją}
begin {EITI}
{K1} if (X = 1) or (X = M) or (Y = 1) or (Y = N)
 then YRA := true {TERM(DATA) = true, jeigu kraštas}
 else
 begin K := 0;
{K2} repeat K := K + 1; {Imama kita produkcija. Ciklas per produkcijas}
{K3} U := X + CX[K]; V := Y + CY[K]; {Nauja agento padėtis}
{K4} if LAB[U, V] = 0 {Langelis tuščias}
 then
 begin BANDSK := BANDSK+1; {Tik įdomumui. Variantų palyginimui}
{K5} L := L + 1; LAB[U,V] := L;{Langelis pažymimas}
{K6} EITI(U, V, YRA); {Rekursyvus kvietimas keliauti toliau}
 if not YRA {Iš čia nebeišeiname}
{K7} then begin
{K8} LAB[U,V] := -1; {0 BACKTRACK atveju}
 L := L - 1;
 end;
 end;
 until YRA or (K = 4);
 end;
end; {EITI}
begin {Pagrindinė programa}
 {1. Įvedamas labirintas}
 for J := N downto 1 do
	begin
		for I := 1 to M do read(LAB[I,J]);
		readln;
	end;
 {2. Įvedama ir pažymima pradinė agento padėtis. Tai pradinė GDB būsena}
 read(X, Y); L := 2; LAB[X,Y] := L;
 {3. Užpildomos produkcijos}
 CX[1] := -1; CY[1] := 0; {Kairėn - į vakarus. 4 }
 CX[2] := 0; CY[2] := -1; {Žemyn - į pietus. 1 * 3 }
 CX[3] := 1; CY[3] := 0; {Dešinėn - į rytus. 2 }
 CX[4] := 0; CY[4] := 1; {Viršun - į šiaurę. }
 {4. Priskiriamos pradinės reikšmės kintamiesiems}
 YRA := false; BANDSK := 0;
 {5. Kviečiama procedūra keliui rasti}
 EITI(X, Y, YRA);
 if YRA
 then writeln('Kelias egzistuoja') {Belieka atspausdinti kelią}
 else writeln('Kelias neegzistuoja'); {Kelias iš labirinto neegzistuoja}
 ClrScr;
 for J := N downto 1 do
	begin
		for I := 1 to M do
			begin
				if LAB[I,J] = 1
				then TextBackground(White)
				else TextBackground(Black);
				if LAB[I,J] = 2
				then TextBackground(Green);
				write(LAB[I,J]:2,' ');
			end;
			writeln;
	end;
end.
