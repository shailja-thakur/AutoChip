module top_module (
	input clk,
	input in,
	output logic out
);

  logic flip_flop_input;
  logic xor_input;

  always_ff @(posedge clk)
    flip_flop_input <= xor_input;

  assign xor_input = in ^ out;
  assign out = flip_flop_input;

endmodule
