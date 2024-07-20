module top_module (
	input clk,
	input in,
	output logic out
);

  logic xor_out;
  logic d_ff_out;

  xor_gate xor1 (.a(clk), .b(in), .out(xor_out));
  d_ff dff1 (.clk(xor_out), .d(out), .q(out));

endmodule
