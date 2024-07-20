module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
	if (c == 0) 
		q = b;
	else if (c == 1)
		q = e;
	else if (c == 2)
		q = a;
	else if (c == 3)
		q = d;
	else if (c == 4)
		q = f;
	else if (c == 5)
		q = f;
	else if (c == 6)
		q = f;
	else if (c == 7)
		q = f;
	else if (c == 8)
		q = f;
	else if (c == 9)
		q = f;
	else if (c == 10)
		q = f;
	else if (c == 11)
		q = f;
	else if (c == 12)
		q = f;
	else if (c == 13)
		q = f;
	else if (c == 14)
		q = f;
	else if (c == 15)
		q = f;
	else
		q = 0;
end

endmodule
