program VALDOVES;
const N = 8;
 NM1 = 7; {N-1}
 N2M1 = 15; {2*N-1}
var
 X : array [1 .. N] of integer;
 VERT : array [1 .. N] of boolean; {Vertikalės}
 KYL : array [-NM1 .. NM1] of boolean; {Kylančios įstrižainės}
 LEID : array [1..N2M1] of boolean; {Besileidžiančios įstrižainės}
 YRA : boolean;
 I, J : integer;
 BANDSK : longint;
procedure TRY (I : integer; var YRA : boolean);
{Įėjimas I – ėjimo numeris. Išėjimas YRA – ar pavyko sustatyti}
 var K : integer;
begin
 K := 0;
 repeat

	K := K + 1; BANDSK := BANDSK + 1;
	if VERT[K] and KYL[K - I] and LEID[I + K - 1]
		then {Vertikalė, kylanti ir besileidžianti įstrižainės yra laisvos}
		begin
		X[I] := K;
		VERT[K] := false; KYL[K - I] := false; LEID[I + K - 1] := false;
		if I < N then
		begin
		TRY(I + 1, YRA);
		if not YRA
		then {Nerastas kelias toliau}
		begin
			VERT[K] := true; KYL[K - I] := true;
			LEID[I + K - 1] := true; {Atlaisvinamas langelis}
		end;
		end
		else YRA := true;
	end;

 until YRA or (K = N);
end; {TRY}
begin {Pagrindinė programa - main program}
 {1. Inicializuojami kintamieji}
 for J := 1 to N do VERT[J] := true;
 for J := -NM1 to NM1 do KYL[J] := true;
 for J := 1 to N2M1 do LEID[J] := true;
 YRA := false; BANDSK := 0;
 {2. Kviečiama procedūra}
 TRY(1, YRA);
 {3. Spausdinama lenta}
 if YRA then
 begin
 for I := N downto 1 do
 begin
 for J := 1 to N do
 if X[I] = J then write(1 : 3) else write(0 : 3);
 writeln;
 end;
 writeln('Bandymų skaičius: ', BANDSK);
 end
 else writeln('Sprendinys neegzistuoja');
end.
