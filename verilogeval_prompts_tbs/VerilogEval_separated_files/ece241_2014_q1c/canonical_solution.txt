	
	wire [8:0] sum = a+b;
	assign s = sum[7:0];
	assign overflow = !(a[7]^b[7]) && (a[7] != s[7]);
	
endmodule
