module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	
	always @* begin
		if (a == 4'b0 && b == 4'b0 && c == 4'b0 && d == 4'b0 && e == 4'b0)
			q = 4'b0;
		else if (a == b && c == 4'b0 && d == e)
			q = b;
		else if (a == b && c == 4'b1 && d == e)
			q = e;
		else if (a == b && c == 4'b2 && d == e)
			q = a;
		else if (a == b && c == 4'b3 && d == e)
			q = d;
		else if (a == b && c == 4'b4 && d == e)
			q = 4'b1111; // Output is set to all 'f'
		else
			q = 4'b1111; // Output is set to all 'f'
	end
endmodule
