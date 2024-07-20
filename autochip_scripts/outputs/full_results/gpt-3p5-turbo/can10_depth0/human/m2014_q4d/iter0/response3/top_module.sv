module top_module (
	input clk,
	input in,
	output logic out
);

logic d;

// XOR gate
assign d = in ^ out;

// D flip-flop
always @(posedge clk)
    out <= d;

endmodule
