module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	reg [7:0] sum;
	
	assign s = sum[7:0];
	
	always @(a, b) begin
		sum = a + b;
		if ((a[7] == b[7]) && (a[7] != sum[7]))
			overflow = 1;
		else
			overflow = 0;
	end
	
endmodule
