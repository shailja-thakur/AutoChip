module top_module (
	input [7:0] in,
	output reg [2:0] pos
);
	always @* begin
		casez(in)
			8'b1111_1110 : pos = 3'b0;
			8'b1_1111_1100 : pos = 3'b1;
			8'b01_1111_1000 : pos = 3'b2;
			8'b011_1111_0000 : pos = 3'b3;
			8'b_1101_1110 : pos = 3'b4;
			8'b_1011_1100 : pos = 3'b5;
			8'b_1001_1000 : pos = 3'b6;
			8'b_0001_0000 : pos = 3'b7;
			default : pos = 3'b0;
		endcase
	end
endmodule
