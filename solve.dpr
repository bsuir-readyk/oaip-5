uses
  SysUtils;

type TArr10 = array[1..10] of Integer;
type TArr100 = array[1..100] of Integer;
type TArr2000 = array[1..2000] of Integer;

{ Util }
procedure fillArrayRandom(var arr: array of Integer);
var
  a: Integer;
begin
  Randomize;
  for a:=1 to Length(arr) do
  begin
    arr[a] := Random(Length(arr))
  end;
end;

procedure fillArraySorted(var arr: array of Integer);
var
  a: Integer;
begin
  Randomize;
  for a:=1 to Length(arr) do
  begin
    arr[a] := a;
  end;
end;

procedure fillArrayRev(var arr: array of Integer);
var
  a: Integer;
begin
  Randomize;
  for a:=1 to Length(arr) do
  begin
    arr[a] := Length(arr) - a + 1;
  end;
end;

procedure logArray(var arr: array of Integer);
var
  a: Integer;
begin
  Write('[');
  for a:=1 to Length(arr) do
  begin
      if a <> 1 then Write(', ');
      Write(arr[a])
  end;
  Writeln(']');
end;

{ Sorts }
procedure BubbleSortWithFlag(var arr: array of Integer; var exchanges: Integer; var comparisons: Integer);
var
  i, j, temp: Integer;
  swapped: Boolean;
begin
  swapped := true;
  i := Length(arr);
  while (i > 0) and swapped do
  begin
    swapped := False;
 
    for j := 0 to i - 1 do
    begin
      Inc(comparisons);
      if arr[j] > arr[j + 1] then
      begin
        Inc(exchanges);
        temp := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := temp;
        swapped := True;
      end;
    end;

    Dec(i);
  end;
end;

procedure ShellSort(var arr: array of Integer; var exchanges: Integer; var comparisons: Integer);
var
  gap, i, j, temp: Integer;
begin
  gap := Length(arr) div 2;
  
  while gap > 0 do
  begin
    for i := gap to High(arr) do
    begin
      temp := arr[i];
      j := i;
      
      while (j >= gap) do
      begin
        Inc(comparisons);
        if arr[j - gap] > temp then
        begin
          Inc(exchanges);
          arr[j] := arr[j - gap];
          j := j - gap;
        end
        else
          Break;
      end;
      
      if j <> i then
      begin
        arr[j] := temp;
        Inc(exchanges);
      end;
    end;
    
    gap := gap div 2;
  end;
end;


var
  i: Integer;

  ce10: array[1..6] of Integer;
  a10Rand, a10Sorted, a10Rev: TArr10;

  ce100: array[1..6] of Integer;
  a100Rand, a100Sorted, a100Rev: TArr100;

  ce2000: array[1..6] of Integer;
  a2000Rand, a2000Sorted, a2000Rev: TArr2000;
begin
  for i:=1 to 6 do 
  begin
    ce10[i] := 0;
    ce100[i] := 0;
    ce2000[i] := 0;
  end;

  fillArrayRandom(a10Rand);
  fillArrayRandom(a100Rand);
  fillArrayRandom(a2000Rand);

  fillArraySorted(a10Sorted);
  fillArraySorted(a100Sorted);
  fillArraySorted(a2000Sorted);

  fillArrayRev(a10Rev);
  fillArrayRev(a100Rev);
  fillArrayRev(a2000Rev);

  {
  logArray(a10Rand);
  logArray(a10Sorted);
  logArray(a10Rev);
  logArray(a100Rand);
  logArray(a100Sorted);
  logArray(a100Rev);
  }
  logArray(a10Rand);
  WriteLn(ce10[1], ' ', ce10[2]);
  ShellSort(a10Rand, ce10[1], ce10[2]);
  logArray(a10Rand);
  WriteLn(ce10[1], ' ', ce10[2]);
end.
