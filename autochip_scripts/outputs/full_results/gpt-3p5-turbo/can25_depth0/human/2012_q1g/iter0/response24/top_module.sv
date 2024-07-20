module top_module (
	input [4:1] x,
	output logic f
);
	logic [1:0] row;
	logic [1:0] col;

	assign row = x[3:2];
	assign col = x[1:0];
	
	always_comb begin
		case ({row, col})
			2'b00_00: f = 1'b1;
			2'b00_01: f = 1'b0;
			2'b00_11: f = 1'b1;
			2'b00_10: f = 1'b1;
			2'b01_00: f = 1'b0;
			2'b01_01: f = 1'b0;
			2'b01_11: f = 1'b0;
			2'b01_10: f = 1'b0;
			2'b11_00: f = 1'b1;
			2'b11_01: f = 1'b1;
			2'b11_11: f = 1'b1;
			2'b11_10: f = 1'b0;
			2'b10_00: f = 1'b1;
			2'b10_01: f = 1'b1;
			2'b10_11: f = 1'b0;
			2'b10_10: f = 1'b1;
		endcase
	end
endmodule
