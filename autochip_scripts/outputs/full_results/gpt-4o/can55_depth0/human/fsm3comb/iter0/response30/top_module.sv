module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always @(*) begin
	case (state)
		2'b00: begin // State A
			next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A if in=0, B if in=1
		end
		2'b01: begin // State B
			next_state = (in == 1'b0) ? 2'b10 : 2'b01; // C if in=0, B if in=1
		end
		2'b10: begin // State C
			next_state = (in == 1'b0) ? 2'b00 : 2'b11; // A if in=0, D if in=1
		end
		2'b11: begin // State D
			next_state = (in == 1'b0) ? 2'b10 : 2'b01; // C if in=0, B if in=1
		end
		default: begin
			next_state = 2'b00; // Default to state A (shouldn't happen)
		end
	endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output is 1 in state D, otherwise 0

endmodule
