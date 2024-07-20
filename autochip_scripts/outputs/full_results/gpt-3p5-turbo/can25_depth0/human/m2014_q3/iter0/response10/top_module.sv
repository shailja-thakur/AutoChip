module top_module (
	input [4:1] x,
	output logic f
);
	always_comb begin
		case (x)
			4'b00xx: f = 1;
			4'b010x: f = 1;
			4'b011x: f = 0;
			4'b1000: f = 0;
			4'b1001: f = 1;
			4'b110x: f = 1;
			default: f = 0;
		endcase
	end
endmodule
