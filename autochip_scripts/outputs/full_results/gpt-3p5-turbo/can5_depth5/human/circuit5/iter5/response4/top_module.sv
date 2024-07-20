module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	always @(*) begin
		case({c, b})
			4'b000: q = a;
			4'b001: q = b;
			4'b010: q = c;
			4'b011: q = d;
			4'b100: q = e;
			default: q = 4'b0000;
		endcase
	end
endmodule
