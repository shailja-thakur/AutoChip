module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] sum; // Adding an extra bit to accommodate overflow
	wire overflow;
	
	assign sum = a + b;
	assign s = sum[7:0]; // Extracting the low 8 bits
	
	assign overflow = (sum[8] != sum[7]); // Checking if the sign bit changed
	
endmodule
