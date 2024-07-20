module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		case({a,b,c,d,e})
			4'b00000, 4'b00001, 4'b10000, 4'b10001: q = b;
			4'b00010, 4'b10010: q = a;
			4'b00011, 4'b10011: q = c;
			4'b00100, 4'b10100: q = d;
			4'b01000, 4'b11000: q = e;
			default: q = 4'b1111;
		endcase
	end
	
endmodule
