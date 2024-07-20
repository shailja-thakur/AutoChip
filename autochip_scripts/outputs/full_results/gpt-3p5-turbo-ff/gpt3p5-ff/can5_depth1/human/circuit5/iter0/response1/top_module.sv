module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		case ({a, b, c, d, e})
			4'b00000: q = b;
			4'b00101: q = e;
			4'b01001: q = a;
			4'b01110: q = d;
			4'b10011: q = f;
			default: q = f;
		endcase
	end
	
endmodule
