module top_module (
	input clk,
	input in,
	output logic out
);

  logic xor_output;
  logic flop_output;

  xor_gate xor1 (
	  .a(in),
	  .b(out),
	  .z(xor_output)
  );

  d_ff_pos_edge flop (
	  .clk(clk),
	  .d(xor_output),
	  .q(flop_output)
  );

  assign out = flop_output;

endmodule
module xor_gate (
	input a,
	input b,
	output z
);

  assign z = a ^ b;

endmodule
module d_ff_pos_edge (
	input clk,
	input d,
	output q
);

  reg q;

  always @(posedge clk) begin
	  q <= d;
  end

  assign q = d;

endmodule
