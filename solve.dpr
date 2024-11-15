uses
  SysUtils;

type TArr10 = array[1..10] of UInt64;
type TArr100 = array[1..100] of UInt64;
type TArr2000 = array[1..2000] of UInt64;

{ Util }
procedure fillArrayRandom(var arr: array of UInt64);
var
  a: UInt64;
begin
  Randomize;
  a:=1;
  while a <= Length(arr) do
  begin
    arr[a] := Random(Length(arr));
    Inc(a);
  end;
end;

procedure fillArraySorted(var arr: array of UInt64);
var
  a: UInt64;
begin
  a:=1;
  while a <= Length(arr) do
  begin
    arr[a] := a;
    Inc(a);
  end;
end;

procedure fillArrayRev(var arr: array of UInt64);
var
  a: UInt64;
begin
  a:=1;
  while a <= Length(arr) do
  begin
    arr[a] := Length(arr) - a + 1;
    Inc(a);
  end;
end;

{ Sorts }
procedure BubbleSortWithFlag(var arr: array of UInt64; var exchanges: UInt64; var comparisons: UInt64);
var
  i, j, temp: UInt64;
  swapped: Boolean;
begin
  exchanges := 0;
  comparisons := 0;

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


procedure ShellSort(var arr: array of UInt64; var exchanges: UInt64; var comparisons: UInt64);
var
    i, znach, index, gap: integer;
begin
    gap := length(arr) div 2;
    while gap > 0 do
    begin
        i := 1;
        while i <= length(arr) do
        begin
            znach := arr[i];
            index := i;
            Inc(exchanges);
            Inc(comparisons);
            while (index > gap) and (znach < arr[index - gap]) do
            begin
                arr[index] := arr[index - gap];
                index := index - gap;
                Inc(exchanges);
                Inc(comparisons);
            end;
            arr[index] := znach;
            Inc(exchanges);
            Inc(i);
        end;
        gap := gap div 2;
    end;
end;

var
  ce10: array[1..12] of UInt64;
  a10Rand, a10Sorted, a10Rev: TArr10;

  ce100: array[1..12] of UInt64;
  a100Rand, a100Sorted, a100Rev: TArr100;

  ce2000: array[1..12] of UInt64;
  a2000Rand, a2000Sorted, a2000Rev, TEMP_TO_DELETE: TArr2000;
begin

  // Fill arrays
  fillArrayRandom(a10Rand);
  fillArrayRandom(a100Rand);
  fillArrayRandom(a2000Rand);

  fillArraySorted(a10Sorted);
  fillArraySorted(a100Sorted);
  fillArraySorted(a2000Sorted);

  fillArrayRev(a10Rev);
  fillArrayRev(a100Rev);
  fillArrayRev(a2000Rev);
  
  // BubbleSortWithFlag arrays
  BubbleSortWithFlag(a10Rand, ce10[1], ce10[2]);
  BubbleSortWithFlag(a100Rand, ce100[1], ce100[2]);
  BubbleSortWithFlag(a2000Rand, ce2000[1], ce2000[2]);

  BubbleSortWithFlag(a10Sorted, ce10[3], ce10[4]);
  BubbleSortWithFlag(a100Sorted, ce100[3], ce100[4]);
  BubbleSortWithFlag(a2000Sorted, ce2000[3], ce2000[4]);

  BubbleSortWithFlag(a10Rev, ce10[5], ce10[6]);
  BubbleSortWithFlag(a100Rev, ce100[5], ce100[6]);
  BubbleSortWithFlag(a2000Rev, ce2000[5], ce2000[6]);

  // ReFill arrays
  fillArrayRandom(a10Rand);
  fillArrayRandom(a100Rand);
  fillArrayRandom(a2000Rand);

  fillArraySorted(a10Sorted);
  fillArraySorted(a100Sorted);
  fillArraySorted(a2000Sorted);

  fillArrayRev(a10Rev);
  fillArrayRev(a100Rev);
  fillArrayRev(a2000Rev);

  // ShellSort arrays
  ShellSort(a10Rand, ce10[7], ce10[8]);
  ShellSort(a100Rand, ce100[7], ce100[8]);
  ShellSort(a2000Rand, ce2000[7], ce2000[8]);

  ShellSort(a10Sorted, ce10[9], ce10[10]);
  ShellSort(a100Sorted, ce100[9], ce100[10]);
  ShellSort(a2000Sorted, ce2000[9], ce2000[10]);

  ShellSort(a10Rev, ce10[11], ce10[12]);
  ShellSort(a100Rev, ce100[11], ce100[12]);
  ShellSort(a2000Rev, ce2000[11], ce2000[12]);

  writeln(a10Rand[1], ', ', a10Rand[2], ', ',a10Rand[9], ', ',a10Rand[10]);

writeln('|---------------------------------------------------------------------|');
writeln('|  Array type    | Bubble Sort             | Shell Sort               |');
writeln('|                |-------------------------|--------------------------|');
writeln('|                | Comparisons | Exchanges | Comparisons | Insertions |');
writeln('|---------------------------------------------------------------------|');
writeln('| Random (10)    | ', ce10[2]:11, ' | ', ce10[1]:9, ' | ', ce10[8]:11, ' |  ', ce10[7]:9, ' |');
writeln('| Sorted (10)    | ', ce10[4]:11, ' | ', ce10[3]:9, ' | ', ce10[10]:11, ' |  ', ce10[9]:9, ' |');
writeln('| Reverse (10)   | ', ce10[6]:11, ' | ', ce10[5]:9, ' | ', ce10[12]:11, ' |  ', ce10[11]:9, ' |');
writeln('|---------------------------------------------------------------------|');
writeln('| Random (100)   | ', ce100[2]:11, ' | ', ce100[1]:9, ' | ', ce100[8]:11, ' |  ', ce100[7]:9, ' |');
writeln('| Sorted (100)   | ', ce100[4]:11, ' | ', ce100[3]:9, ' | ', ce100[10]:11, ' |  ', ce100[9]:9, ' |');
writeln('| Reverse (100)  | ', ce100[6]:11, ' | ', ce100[5]:9, ' | ', ce100[12]:11, ' |  ', ce100[11]:9, ' |');
writeln('|---------------------------------------------------------------------|');
writeln('| Random (2000)  | ', ce2000[2]:11, ' | ', ce2000[1]:9, ' | ', ce2000[8]:11, ' |  ', ce2000[7]:9, ' |');
writeln('| Sorted (2000)  | ', ce2000[4]:11, ' | ', ce2000[3]:9, ' | ', ce2000[10]:11, ' |  ', ce2000[9]:9, ' |');
writeln('| Reverse (2000) | ', ce2000[6]:11, ' | ', ce2000[5]:9, ' | ', ce2000[12]:11, ' |  ', ce2000[11]:9, ' |');
writeln('|---------------------------------------------------------------------|');
end.
