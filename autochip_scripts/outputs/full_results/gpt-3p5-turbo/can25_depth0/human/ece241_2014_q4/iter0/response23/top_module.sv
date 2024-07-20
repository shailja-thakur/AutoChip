module top_module (
	input clk,
	input x,
	output z
);

// D flip-flops
reg d1, d2, d3;

// Complementary outputs of the flip-flops
wire q1_bar, q2_bar, q3_bar;

// Outputs of the three gates
wire xor_out, and_out, or_out;

// XNOR gate
assign z = (d1 ^ xor_out) ^ (d2 & and_out) ^ (d3 | or_out);

// Connection of inputs and flip-flops
always @(posedge clk) begin
	d1 <= x;
	d2 <= ~d1;
	d3 <= ~d2;
end

// Connection of flip-flop outputs and gates
assign xor_out = d1;
assign and_out = ~d2;
assign or_out = ~d3;

endmodule
