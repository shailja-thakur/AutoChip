module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00xx: f = 0;
		4'b01x1: f = 0;
		4'b01x0: f = 1;
		4'b110x: f = 1;
		4'b1111: f = 0;
		default: f = 0; // Don't care case
	endcase
end

endmodule
