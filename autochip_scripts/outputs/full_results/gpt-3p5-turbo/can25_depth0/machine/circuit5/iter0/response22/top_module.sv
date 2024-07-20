module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(c)
begin
	if (c == 0)
		q = b;
	else if (c == 1)
		q = e;
	else if (c == 2)
		q = a;
	else if (c == 3)
		q = d;
	else
		q = 4'hf;
end

endmodule
