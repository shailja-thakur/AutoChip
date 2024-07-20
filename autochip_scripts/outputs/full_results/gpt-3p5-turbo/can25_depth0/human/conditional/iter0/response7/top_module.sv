module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always @* begin
		
		min = a;
		
		// Compare b with min
		if (b < min) 
			min = b;
		
		// Compare c with min
		if (c < min)
			min = c;
		
		// Compare d with min
		if (d < min)
			min = d;
		
	end
	
endmodule
