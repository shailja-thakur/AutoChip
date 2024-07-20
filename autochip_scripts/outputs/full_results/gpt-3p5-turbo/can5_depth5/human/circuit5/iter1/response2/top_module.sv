module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @(*) begin
		if(a == 4'b0001 && b == 4'b1010 && c == 4'b1110 && d == 4'b1101 && e == 4'b1110)
			q = 4'b1011;
		else if(a == 4'b0001 && b == 4'b1010 && c == 4'b1110 && d == 4'b1101 && e == 4'b1010)
			q = 4'b1110;
		else if(a == 4'b0001 && b == 4'b1010 && c == 4'b1110 && d == 4'b1101 && e == 4'b0001)
			q = 4'b0000;
		else if(a == 4'b0001 && b == 4'b1010 && c == 4'b1110 && d == 4'b1101 && e == 4'b1101)
			q = 4'b1101;
		else if(a == 4'b0001 && b == 4'b1010 && c == 4'b1110 && d == 4'b1101 && e == 4'b1111)
			q = 4'b0110;
		else 
			q = 4'b1010;
		end
	end
endmodule
