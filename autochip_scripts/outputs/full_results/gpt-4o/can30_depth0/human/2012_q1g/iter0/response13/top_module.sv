module top_module (
	input [4:1] x,
	output logic f
);
	always @(*) begin
		case (x)
            // x[3]x[4]
			4'b0000: f = 1'b1; // 00 00
			4'b0001: f = 1'b0; // 00 01
			4'b0011: f = 1'b0; // 00 11
			4'b0010: f = 1'b1; // 00 10
			4'b0100: f = 1'b0; // 01 00
			4'b0101: f = 1'b0; // 01 01
			4'b0111: f = 1'b0; // 01 11
			4'b0110: f = 1'b0; // 01 10
			4'b1100: f = 1'b1; // 11 00
			4'b1101: f = 1'b1; // 11 01
			4'b1111: f = 1'b1; // 11 11
			4'b1110: f = 1'b0; // 11 10
			4'b1000: f = 1'b1; // 10 00
			4'b1001: f = 1'b1; // 10 01
			4'b1011: f = 1'b0; // 10 11
			4'b1010: f = 1'b1; // 10 10
			default: f = 1'b0; // Default case
		endcase
	end
endmodule
