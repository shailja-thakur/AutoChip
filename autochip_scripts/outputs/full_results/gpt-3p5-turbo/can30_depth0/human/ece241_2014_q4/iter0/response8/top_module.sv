module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;  // Flip-flop outputs
wire q1, q2, q3;  // Flip-flop outputs complemented

// Flip-flop D inputs
assign q1 = ~d1;
assign q2 = ~d2;
assign q3 = ~d3;

// Flip-flop feedback connections
assign d1 = x ^ q1;
assign d2 = x & q2;
assign d3 = x | q3;

// XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

// Clock edge-triggered flip-flops
always @(posedge clk) begin
    d1 <= x ^ q1;
    d2 <= x & q2;
    d3 <= x | q3;
end

endmodule
