module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

always @(*) begin
	casez (in)
		4'bzzz1: pos = 2'd0;
		4'bzz10: pos = 2'd1;
		4'bz100: pos = 2'd2;
		4'b1000: pos = 2'd3;
		default: pos = 2'd0;
	endcase
end

endmodule
