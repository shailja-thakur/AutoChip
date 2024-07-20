module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

	always @(*) begin
		casez (in)
			4'b1??? : pos = 2'd3; // in[3] is the first 1
			4'b01?? : pos = 2'd2; // in[2] is the first 1
			4'b001? : pos = 2'd1; // in[1] is the first 1
			4'b0001 : pos = 2'd0; // in[0] is the first 1
			default : pos = 2'd0; // no bits are high
		endcase
	end

endmodule
