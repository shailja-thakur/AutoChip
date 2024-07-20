module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		case (1'b1)
			1'b1	:	q = b;
			(a == c)	:	q = e;
			(a !== b)	:	q = a;
			default	:	q = d;
		endcase
	end

endmodule
