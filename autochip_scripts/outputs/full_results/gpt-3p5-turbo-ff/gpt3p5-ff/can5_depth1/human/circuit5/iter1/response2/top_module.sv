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
			5'b00000, 5'b00001, 5'b00100: q = b;
			5'b00011: q = c;
			5'b00100: q = d;
			5'b00101: q = e;
			5'b00110: q = a;
			default: q = 4'b1111;
		endcase
	end
	
endmodule
