module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] s_reg;
	wire overflow_reg;

	// Adder module to compute s
	adder_module adder (
		.a(a),
		.b(b),
		.s(s_reg)
	);

	// Overflow detection module
	overflow_module overflow_detector (
		.a(a),
		.b(b),
		.s(s_reg),
		.overflow(overflow_reg)
	);

	always @(posedge clk) begin
		s <= s_reg;
		overflow <= overflow_reg;
	end

endmodule
module adder_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s
);
	
	always @(*) begin
		s = a + b;
	end
	
endmodule
module overflow_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] s,
	output reg overflow
);
	
	always @(*) begin
		// Check if there is overflow
		if ((a[7] && b[7] && !s[7]) || (!a[7] && !b[7] && s[7])) begin
			overflow = 1;
		end
		else begin
			overflow = 0;
		end
	end
	
endmodule
