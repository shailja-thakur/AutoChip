module top_module (
	input clk,
	input in,
	output logic out
);

logic flip_flop_out;
logic xor_out;

always_ff @(posedge clk)
    flip_flop_out <= xor_out;

assign xor_out = in ^ out;

endmodule
