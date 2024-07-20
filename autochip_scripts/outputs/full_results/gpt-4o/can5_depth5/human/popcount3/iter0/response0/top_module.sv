module top_module (
	input [2:0] in,
	output [1:0] out
);

	always @(*) begin
		case (in)
			3'b000: out = 2'd0;
			3'b001: out = 2'd1;
			3'b010: out = 2'd1;
			3'b011: out = 2'd2;
			3'b100: out = 2'd1;
			3'b101: out = 2'd2;
			3'b110: out = 2'd2;
			3'b111: out = 2'd3;
			default: out = 2'd0; // Should never occur for 3-bit input
		endcase
	end

endmodule
