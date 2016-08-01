function checkerboard = CheckerBoard()

pixelsPerChecker = 10;

yCheckers = 10;
xCheckers = 10;

whiteChecker = zeros(pixelsPerChecker, pixelsPerChecker);
blackChecker = ones(pixelsPerChecker, pixelsPerChecker);

checkerboard = whiteChecker;

for i = 1:(xCheckers)

  color = mod(i, 2);

  if color == 0

    checkerboard = [checkerboard, whiteChecker];

  else

    checkerboard = [checkerboard, blackChecker];

  endif
endfor

stripe1 = checkerboard(:, (pixelsPerChecker + 1):end);
stripe2 = checkerboard(:, 1:(pixelsPerChecker*xCheckers));

checkerboard = stripe1;

for i = 1:yCheckers

  stripe = mod(i, 2);

  if stripe == 1

    checkerboard = [checkerboard; stripe2];

  else 

    checkerboard = [checkerboard; stripe1];

  endif
endfor

checkerboard = 255.*checkerboard;

end



