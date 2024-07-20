module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	// Wire declaration for intermediate signals
	wire [8:0] sum;
	wire carry;

	// Adder
	assign sum = a + b;
	assign carry = sum[8];

	// Overflow detection
	always @(*) begin
		if (sum[8] != sum[7])
			overflow = 1;
		else
			overflow = 0;
	end

	// Result assignment
	always @(posedge clk or posedge rst) begin
		if (rst)
			s <= 0;
		else
			s <= sum[7:0];
	end

endmodule
