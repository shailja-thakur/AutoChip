module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @(*) begin
		case ({a[2], b[2], c[2], d[2], e[2]})
            5'b00001: q = b;
            5'b00010: q = e;
            5'b00011: q = a;
            5'b00100: q = d;
            5'b00101: q = f;
            5'b00110: q = f;
            5'b00111: q = f;
            5'b01000: q = f;
            5'b01001: q = f;
            5'b01010: q = f;
            5'b01011: q = f;
            5'b01100: q = f;
            5'b01101: q = f;
            5'b01110: q = f;
            5'b01111: q = f;
            5'b10000: q = f;
            5'b10001: q = f;
            5'b10010: q = f;
            5'b10011: q = f;
            5'b10100: q = f;
            5'b10101: q = f;
            5'b10110: q = f;
            5'b10111: q = f;
            5'b11000: q = f;
            5'b11001: q = f;
			default: q = 4'b x;
		endcase
	end

endmodule
