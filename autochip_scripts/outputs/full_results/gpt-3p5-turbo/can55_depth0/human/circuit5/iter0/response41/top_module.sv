module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(a or b or c or d or e) begin
	case ({a,b,c,d,e})
		4'b00000: q <= b;
		4'b00001: q <= e;
		4'b00010: q <= a;
		4'b00011: q <= d;
		4'b00100: q <= f;
		4'b00101: q <= f;
		4'b00110: q <= f;
		4'b00111: q <= f;
		4'b01000: q <= f;
		4'b01001: q <= f;
		4'b01010: q <= f;
		4'b01011: q <= f;
		4'b01100: q <= f;
		4'b01101: q <= f;
		4'b01110: q <= f;
		4'b01111: q <= f;
		4'b10000: q <= b;
	endcase
end

endmodule
