module top_module (
	input a,
	input b,
	input sel,
	output out
);
  // Implementation of multiplexer using select statement
  always @ (a, b, sel)
  begin
    if (sel)
      out = b;
    else
      out = a;
  end
endmodule
