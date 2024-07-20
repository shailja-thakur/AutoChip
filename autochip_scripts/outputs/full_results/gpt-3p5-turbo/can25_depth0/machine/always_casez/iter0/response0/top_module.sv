module top_module (
	input [7:0] in,
	output reg [2:0] pos
);
always @(*) begin
	casez(in)
		8'b0000_0001: pos <= 3'b0;
		8'b0000_0010: pos <= 3'b1;
		8'b0000_0100: pos <= 3'b2;
		8'b0000_1000: pos <= 3'b3;
		8'b0001_0000: pos <= 3'b4;
		8'b0010_0000: pos <= 3'b5;
		8'b0100_0000: pos <= 3'b6;
		8'b1000_0000: pos <= 3'b7;
		default: pos <= 3'b0;
	endcase
end
endmodule
