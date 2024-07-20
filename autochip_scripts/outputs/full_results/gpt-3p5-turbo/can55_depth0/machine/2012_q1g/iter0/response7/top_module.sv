module top_module (
	input [4:0] x,
	output logic f
);

	always_comb begin
		case (x)
			4'b_0000: f = 1;
			4'b_0001: f = 1;
			4'b_0010: f = 0;
			4'b_0011: f = 0;
			4'b_0100: f = 1;
			4'b_0101: f = 1;
			4'b_0110: f = 1;
			4'b_0111: f = 0;
			4'b_1000: f = 0;
			4'b_1001: f = 0;
			4'b_1010: f = 0;
			4'b_1011: f = 0;
			4'b_1100: f = 1;
			4'b_1101: f = 0;
			4'b_1110: f = 1;
			4'b_1111: f = 1;
		endcase
	end

endmodule
