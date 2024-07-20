module top_module (
	input clk,
	input x,
	output z
);

  reg d1, d2, d3;
  wire xnor_result;
  wire x_flipflop;
  wire and_flipflop;
  wire or_flipflop;

  assign z = xnor_result;

  xor(x_flipflop, x, d1); 
  and(and_flipflop, ~d2, x);
  or(or_flipflop, ~d3, x);

  xnor(xnor_result, x_flipflop, and_flipflop, or_flipflop);

  always @(posedge clk) begin
    d1 <= x;
    d2 <= d1;
    d3 <= ~d2;
  end

endmodule
