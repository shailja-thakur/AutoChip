module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk)
  if (L)
    Q <= R;
  else
    Q <= (E) ? w : Q;

endmodule
