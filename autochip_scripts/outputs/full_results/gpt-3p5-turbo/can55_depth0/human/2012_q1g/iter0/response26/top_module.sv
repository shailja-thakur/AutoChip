module top_module (
	input [4:1] x,
	output logic f
);

	logic [3:0] k_map;
	assign k_map = {x[3], x[4], x[2], x[1]};
	
	always_comb begin
		case (k_map)
		
			4'b0000: f = 1'b1;
			4'b0001: f = 1'b0;
			4'b0011: f = 1'b0;
			4'b0010: f = 1'b1;
			4'b0111: f = 1'b1;
			4'b0101: f = 1'b1;
			4'b0100: f = 1'b0;
			4'b0110: f = 1'b0;
			4'b1110: f = 1'b1;
			4'b1111: f = 1'b0;
			4'b1101: f = 1'b1;
			4'b1100: f = 1'b0;
			default: f = 1'b0;
		endcase
	end
endmodule
