module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(*) begin

	if (a == 4'b0 && b == 4'b0 && c == 4'b0)
		q = b;

	else if (a == 4'b1 && b == 4'b1 && c == 4'b0)
		q = e;

	else if (a == 4'b2 && b == 4'b2 && c == 4'b0)
		q = a;

	else if (a == 4'b3 && b == 4'b3 && c == 4'b0)
		q = d;

	else
		q = f;

end

endmodule
