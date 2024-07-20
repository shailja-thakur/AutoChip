module top_module (
	input clk,
	input in,
	output logic out
);

  logic xor_output;
  logic flip_flop_output;

  xor_gate xor1(.a(in), .b(out), .y(xor_output));
  d_flip_flop flip_flop1(.clk(clk), .d(xor_output), .q(flip_flop_output));

  assign out = flip_flop_output;

endmodule
module xor_gate(
  input a,
  input b,
  output y
);

  assign y = a ^ b;

endmodule
module d_flip_flop(
  input clk,
  input d,
  output q
);

  reg q;

  always @(posedge clk) begin
    q <= d;
  end

endmodule
