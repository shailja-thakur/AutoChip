module top_module (
	input clk,
	input in,
	output logic out
);

logic d;  // Intermediate signal for D flip-flop

// XOR gate
assign d = in ^ out;

// D Flip-Flop
always_ff @(posedge clk)
    out <= d;

endmodule
