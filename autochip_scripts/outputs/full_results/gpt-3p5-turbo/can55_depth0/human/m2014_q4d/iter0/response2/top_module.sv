module top_module (
	input clk,
	input in,
	output logic out
);

logic d;

// create XOR gate
assign d = in ^ out;

// create D flip-flop
always_ff @(posedge clk)
	out <= d;

endmodule
