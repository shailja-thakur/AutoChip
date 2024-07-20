module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @*
begin
	case ({a, b, c, d, e})
		4'bxxxxx: q = 4'bx;
		4'bxxxx0: q = b;
		4'bxxxx1: q = e;
		4'bxx001: q = a;
		4'bxx010: q = d;
		default: q = 4'bxxxf;
	endcase
end

endmodule
