module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// internal wires and registers
	reg [8:0] sum_ext;
	reg overflow;
	
	// Adder
	assign sum_ext = a + b;

	// Check if there is an overflow
	always @(*) begin
		if (a[7] == b[7] && sum_ext[8] != a[7])
			overflow = 1;
		else
			overflow = 0;
	end
	
	// Assign the sum with proper sign extension and overflow
	assign s = sum_ext[7:0];
	
endmodule
