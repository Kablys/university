Program VALDOVES;
Var 
{X :   array of integer;
    VERT :   array of boolean; 
    KYL :   array of boolean;
		LEID :   array of boolean;
		}
		X : array [1 .. 20] of integer;
		 VERT : array [1 .. 20] of boolean; {Vertikalės}
		  KYL : array [-20 .. 20] of boolean; {Kylančios įstrižainės}
		   LEID : array [1..20] of boolean; 
    YRA :   boolean;
    I, J :   integer;
    BANDSK :   longint;
	step : integer;
	N, NM1, N2M1 : integer;
Procedure 
Try
    (I : integer; Var YRA : boolean);
{Įėjimas I – ėjimo numeris. Išėjimas YRA – ar pavyko sustatyti}

    Var K :   integer;
    Begin
        K := 0;
        Repeat


            K := K + 1;
            BANDSK := BANDSK + 1;
            If VERT[K] And KYL[K - I] And LEID[I + K - 1]
                Then {Vertikalė, kylanti ir besileidžianti įstrižainės yra laisvos}
                Begin
                    X[I] := K;
                    VERT[K] := false;
                    KYL[K - I] := false;
                    LEID[I + K - 1] := false;

						write(step,'. ');
						for J := 2 to I do write('  ');
						writeln('x[',I,']=',K,' OK');
					step := step + 1;

                    If I < N Then
                        Begin
                            Try
                                (I + 1, YRA);
                                If Not YRA
                                    Then {Nerastas kelias toliau}
                                    Begin
                                        VERT[K] := true;
                                        KYL[K - I] := true;
                                        LEID[I + K - 1] := true; {Atlaisvinamas langelis}
                                    End;
                        End
                    Else YRA := true;
                End
				Else 
					begin
						write(step,'. ');
						for J := 2 to I do write('  ');
						writeln('x[',I,']=',K,' Kerta');
						step := step + 1;
					end


					{writeln(BANDSK-1,'. x[', K,']=', I, YRA);}
        Until YRA Or (K = N);
    End; {TRY}
    Begin {Pagrindinė programa - main program}
 {1. Inicializuojami kintamieji}
	N :=   8;
 write('Iveskite lentos dydi(nuo 1 iki 15):');
	read(N);
	if ((N > 15) or (N < 1)) then
		begin
			writeln ('Blogas lentos dydis');
			exit;
		end;
		
	{X :   array of integer;
    VERT :   array of boolean;
    KYL :   array of boolean; 
    LEID :   array of boolean;}
	{SetLength(X, N);
	SetLength(VERT, N);
	SetLength(KYL, 2*N);
	SetLength(LEID, N);}
	NM1 :=   N-1;
	N2M1 :=   (2*N)-1;
        For J := 1 To N Do
            VERT[J] := true;
        For J := -NM1 To NM1 Do
            KYL[J] := true;
        For J := 1 To N2M1 Do
            LEID[J] := true;
        YRA := false;
        BANDSK := 0;
		step := 1;
 {2. Kviečiama procedūra}
        Try
            (1, YRA);
	{SetLength(X, 0);
	SetLength(VERT, 0);
	SetLength(KYL, 0);
	SetLength(LEID, 0);}
 {3. Spausdinama lenta}
            If YRA Then
                Begin
                    For I := N Downto 1 Do
                        Begin
                            For J := 1 To N Do
                                If X[I] = J Then write(1 : 3)
                                Else write(0 : 3);
                            writeln;
                        End;
                    writeln('Bandymų skaičius: ', BANDSK);
                End
            Else writeln('Sprendinys neegzistuoja');
    End.
