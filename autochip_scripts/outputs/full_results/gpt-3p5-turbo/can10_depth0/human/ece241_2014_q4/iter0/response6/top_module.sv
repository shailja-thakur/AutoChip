module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;

// D flip-flop 1
always @(posedge clk) begin
	if (x ^ d1)
		d1 <= 1'b1;
	else
		d1 <= 1'b0;
end

// D flip-flop 2
always @(posedge clk) begin
	if (x & ~d2)
		d2 <= 1'b1;
	else
		d2 <= 1'b0;
end

// D flip-flop 3
always @(posedge clk) begin
	if (x | ~d3)
		d3 <= 1'b1;
	else
		d3 <= 1'b0;
end

// XNOR gate
assign z = ~(d1 ^ d2 ^ d3);

endmodule
