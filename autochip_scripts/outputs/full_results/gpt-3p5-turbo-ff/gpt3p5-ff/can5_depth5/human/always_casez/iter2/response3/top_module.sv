module top_module (
	input [7:0] in,
	output reg [2:0] position
);

	always @(*) begin
		position = 0;
		casez(in)
			8'b00000001 : position = 1;
			8'b00000010 : position = 2;
			8'b00000100 : position = 3;
			8'b00001000 : position = 4;
			8'b00010000 : position = 5;
			8'b00100000 : position = 6;
			8'b01000000 : position = 7;
			8'b10000000 : position = 8;
			default: position = 0;
		endcase
	end

endmodule
