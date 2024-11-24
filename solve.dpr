uses
  sysutils;


type
  TFillType = (ftRandom, ftSorted, ftReverse);


procedure fill(var arr: array of integer; fillType: TFillType);
var
  i: integer;
begin
  randomize;

  i := low(arr);
  while i <= high(arr) do
  begin
    case fillType of
      ftRandom:  arr[i] := random(2000);
      ftSorted:  arr[i] := i;
      ftReverse: arr[i] := high(arr) - i;
    end;
    Inc(i);
  end;
end;


procedure SortBubbleWFlag(var arr: array of integer; var comparisons, insertions: uint64);
var
  i, j, temp: integer;
  swapped: boolean;
begin
  comparisons := 0;
  insertions := 0;
  
  i := 0;
  swapped := true;
  while (i < length(arr)-1) and swapped do
  begin
    j := 0;
    swapped := false;
    
    while j < length(arr)-1-i do
    begin
      Inc(comparisons);
      
      if arr[j] > arr[j+1] then
      begin
        temp := arr[j];
        arr[j] := arr[j+1];
        arr[j+1] := temp;
        
        Inc(insertions, 3);
        swapped := true;
      end;
      
      Inc(j);
    end;
    
    i := i + 1;
  end;
end;


procedure SortShell(var arr: array of integer; var comparisons, insertions: uint64);
var
  gap, i, j, temp: integer;
  needNextPass: boolean;
begin
  comparisons := 0;
  insertions := 0;
  
  gap := length(arr) div 2;
  while gap > 0 do
  begin
    i := gap;
    while i < length(arr) do
    begin
      temp := arr[i];
      
      j := i;
      needNextPass := true;
      while (j >= gap) and needNextPass do
      begin
        Inc(comparisons);
        
        if arr[j-gap] > temp then
        begin
          arr[j] := arr[j-gap];
          Inc(insertions);
          j := j - gap;
        end
        else
          needNextPass := false;
      end;
      
      if j <> i then
      begin
        arr[j] := temp;
        Inc(insertions);
      end;
      
      Inc(i);
    end;
    
    gap := gap div 2;
  end;
end;


procedure logArray(var arr: array of integer);
var
  i: integer;
begin
  i := low(arr);
  write('[');
  while i <= high(arr) do
  begin
    if i <> low(arr) then write(', ');

    write(arr[i]);

    Inc(i);
  end;
  writeln(']');
end;

var
  arr10: array[1..10] of integer;
  arr100: array[1..100] of integer;
  arr2000: array[1..2000] of integer;
  insertions, comparisons: uint64;
begin

writeln('|----------------------------------------------------------------------|');
writeln('|  Array type    | Bubble Sort              | Shell Sort               |');
writeln('|                |--------------------------|--------------------------|');
writeln('|                | Comparisons | Insertions | Comparisons | Insertions |');
writeln('|----------------------------------------------------------------------|');

write('| Random (10)    | ');
  fill(arr10, ftRandom);
  SortBubbleWFlag(arr10, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr10, ftRandom);
  SortShell(arr10, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

write('| Sorted (10)    | ');
  fill(arr10, ftSorted);
  SortBubbleWFlag(arr10, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr10, ftSorted);
  SortShell(arr10, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

write('| Reverse (10)   | ');
  fill(arr10, ftReverse);
  SortBubbleWFlag(arr10, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr10, ftReverse);
  SortShell(arr10, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

writeln('|----------------------------------------------------------------------|');

write('| Random (100)   | ');
  fill(arr100, ftRandom);
  SortBubbleWFlag(arr100, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr100, ftRandom);
  SortShell(arr100, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

write('| Sorted (100)   | ');
  fill(arr100, ftSorted);
  SortBubbleWFlag(arr100, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr100, ftSorted);
  SortShell(arr100, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

write('| Reverse (100)  | ');
  fill(arr100, ftReverse);
  SortBubbleWFlag(arr100, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr100, ftReverse);
  SortShell(arr100, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

writeln('|----------------------------------------------------------------------|');

write('| Random (2000)  | ');
  fill(arr2000, ftRandom);
  SortBubbleWFlag(arr2000, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr2000, ftRandom);
  SortShell(arr2000, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

write('| Sorted (2000)  | ');
  fill(arr2000, ftSorted);
  SortBubbleWFlag(arr2000, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr2000, ftSorted);
  SortShell(arr2000, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

write('| Reverse (2000) | ');
  fill(arr2000, ftReverse);
  SortBubbleWFlag(arr2000, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr2000, ftReverse);
  SortShell(arr2000, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');

writeln('|----------------------------------------------------------------------|');

end.

