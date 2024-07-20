module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(in) begin
	casez(in)
		8'b00000001 : pos <= 3'b0;
		8'b00000101 : pos <= 3'b1;
		8'b00001010 : pos <= 3'b2;
		8'b00001111 : pos <= 3'b3;
		8'b00010101 : pos <= 3'b4;
		8'b00011010 : pos <= 3'b5;
		8'b00011111 : pos <= 3'b6;
		8'b00101010 : pos <= 3'b7;
		default : pos <= 3'b0;
	endcase
end

endmodule
