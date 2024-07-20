module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		case({a, b, c, d, e})
			4'b00100: q = b; // when a = 0, b = 1, c = 0, d = 4, e = e, q = b
			4'b00101: q = e; // when a = 0, b = 1, c = 0, d = 5, e = e, q = e
			4'b00110: q = a; // when a = 0, b = 1, c = 0, d = 6, e = e, q = a
			4'b00111: q = d; // when a = 0, b = 1, c = 0, d = 7, e = e, q = d
			4'b01000: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 8, e = e, q = 15
			4'b01001: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 9, e = e, q = 15
			4'b01010: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 10, e = e, q = 15
			4'b01011: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 11, e = e, q = 15
			4'b01100: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 12, e = e, q = 15
			4'b01101: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 13, e = e, q = 15
			4'b01110: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 14, e = e, q = 15
			4'b01111: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 15, e = e, q = 15
			4'b10000: q = 4'b1111; // when a = 0, b = 1, c = 0, d = 0, e = e, q = 15
			default: q = 4'b1111; // for all other inputs, q = 15
		endcase
	end

endmodule
