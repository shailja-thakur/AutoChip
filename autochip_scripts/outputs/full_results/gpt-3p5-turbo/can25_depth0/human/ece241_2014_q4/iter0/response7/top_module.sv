module top_module (
	input clk,
	input x,
	output z
);

reg d_ff1, d_ff2, d_ff3;
wire d_ff1_out, d_ff2_out, d_ff3_out;

// XOR gate
assign d_ff1_out = d_ff1 ^ x;
// AND gate
assign d_ff2_out = d_ff2 & ~d_ff2;
// OR gate
assign d_ff3_out = d_ff3 | ~d_ff3;

// XNOR gate
assign z = d_ff1_out ^ d_ff2_out ^ d_ff3_out;

always @(posedge clk) begin
	d_ff1 <= d_ff1_out;
	d_ff2 <= d_ff2_out;
	d_ff3 <= d_ff3_out;
end

endmodule
