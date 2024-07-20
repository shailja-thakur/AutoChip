module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		// Output f for each input combination
		4'b00d: f = 0;   // x[3] = 0, x[4] = 0, don't care for x[1] and x[2]
		4'b01d: f = 0;   // x[3] = 0, x[4] = 1, don't care for x[1] and x[2]
		4'b11d: f = 1;   // x[3] = 1, x[4] = 1, don't care for x[1] and x[2]
		4'b10d: f = 1;   // x[3] = 1, x[4] = 0, don't care for x[1] and x[2]
		default: f = 0;
	endcase
end

endmodule
