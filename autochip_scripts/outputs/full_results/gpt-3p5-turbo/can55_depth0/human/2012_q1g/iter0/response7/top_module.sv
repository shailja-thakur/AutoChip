module top_module (
	input [4:1] x,
	output logic f
);
	logic f_tmp;

	always_comb begin
		case (x)
			4'b0000: f_tmp = 1'b1;
			4'b0001,
			4'b0101,
			4'b0111,
			4'b1011: f_tmp = 1'b0;
			4'b0110,
			4'b1010,
			4'b1100,
			4'b1101: f_tmp = 1'b1;
			default: f_tmp = 1'b0;
		endcase
	end

	assign f = f_tmp;

endmodule
