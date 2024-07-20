module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
	if (a == 3'b0 && b == 3'b0 && c == 3'b0 && d == 3'b0 && e == 3'b0)
		q = b; 
	else if (c == 3'b1)
		q = e;
	else if (c == 3'b2)
		q = a;
	else if (c == 3'b3)
		q = d;
	else
		q = 4'b1111;
end

endmodule
