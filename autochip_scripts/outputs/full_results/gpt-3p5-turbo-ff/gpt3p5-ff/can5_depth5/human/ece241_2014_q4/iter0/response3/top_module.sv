module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire xor_in, and_in, or_in;
wire z;

// D flip-flop 1
always @(posedge clk) begin
	d1 <= xor_in;
end

// D flip-flop 2
always @(posedge clk) begin
	d2 <= ~d2;
end

// D flip-flop 3
always @(posedge clk) begin
	d3 <= ~d3;
end

// XOR gate input
assign xor_in = x ^ d1;

// AND gate input
assign and_in = x & ~d2;

// OR gate input
assign or_in = x | ~d3;

// Three-input XNOR gate
assign z = ~(xor_in ^ and_in ^ or_in);

endmodule
