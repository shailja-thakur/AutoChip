module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	wire [7:0] sum;
	
	assign s = sum[7:0];
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);
	
	// Adder circuit
	assign sum[0] = a[0] ^ b[0];
	assign sum[1] = a[1] ^ b[1] ^ (a[0] & b[0]);
	assign sum[2] = a[2] ^ b[2] ^ (sum[1] & (a[0] ^ b[0]));
	assign sum[3] = a[3] ^ b[3] ^ (sum[2] & (a[0] ^ b[0]));
	assign sum[4] = a[4] ^ b[4] ^ (sum[3] & (a[0] ^ b[0]));
	assign sum[5] = a[5] ^ b[5] ^ (sum[4] & (a[0] ^ b[0]));
	assign sum[6] = a[6] ^ b[6] ^ (sum[5] & (a[0] ^ b[0]));
	assign sum[7] = a[7] ^ b[7] ^ (sum[6] & (a[0] ^ b[0]));
endmodule
