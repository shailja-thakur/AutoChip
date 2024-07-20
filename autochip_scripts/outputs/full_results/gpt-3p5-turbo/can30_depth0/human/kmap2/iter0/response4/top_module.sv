module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

  // Implement the Karnaugh map as a series of if-else statements
  always @ (a, b, c, d) begin
    if (a == 0 && b == 0 && c == 0 && d == 0)
      out = 1;
    else if (a == 0 && b == 0 && c == 0 && d == 1)
      out = 1;
    else if (a == 0 && b == 0 && c == 1 && d == 1)
      out = 0;
    else if (a == 0 && b == 0 && c == 1 && d == 0)
      out = 1;
    else if (a == 0 && b == 1 && c == 0 && d == 0)
      out = 1;
    else if (a == 0 && b == 1 && c == 0 && d == 1)
      out = 0;
    else if (a == 0 && b == 1 && c == 1 && d == 0)
      out = 0;
    else if (a == 0 && b == 1 && c == 1 && d == 1)
      out = 1;
    else if (a == 1 && b == 0 && c == 0 && d == 0)
      out = 1;
    else if (a == 1 && b == 0 && c == 0 && d == 1)
      out = 1;
    else if (a == 1 && b == 0 && c == 1 && d == 0)
      out = 0;
    else if (a == 1 && b == 0 && c == 1 && d == 1)
      out = 0;
    else if (a == 1 && b == 1 && c == 0 && d == 0)
      out = 1;
    else if (a == 1 && b == 1 && c == 0 && d == 1)
      out = 1;
    else if (a == 1 && b == 1 && c == 1 && d == 0)
      out = 0;
    else if (a == 1 && b == 1 && c == 1 && d == 1)
      out = 1;
  end

endmodule
