module top_module (
	input clk,
	input x,
	output z
);
	
	reg d1, d2, d3;
	wire q1, q2, q3;
	wire y1, y2, y3;

	// D flip flops
	always @(posedge clk) begin
		d1 <= x ^ q1;
		d2 <= ~q2 & x;
		d3 <= ~q3 | x;
	end
	
	// Flip flop outputs
	assign q1 = d1;
	assign q2 = d2;
	assign q3 = d3;
	
	// Gate outputs
	assign y1 = d1;
	assign y2 = ~d2;
	assign y3 = ~d3;
	
	// XNOR gate
	assign z = y1 ^ y2 ^ y3;
endmodule
