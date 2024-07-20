module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		if (a == 4'b0000 || a == 4'b0001)
			q = b;
		else if (a == 4'b0010)
			q = c;
		else if (a == 4'b0011)
			q = d;
		else if (a == 4'b0100)
			q = e;
		else
			q = 4'b1111;
	end
	
endmodule
