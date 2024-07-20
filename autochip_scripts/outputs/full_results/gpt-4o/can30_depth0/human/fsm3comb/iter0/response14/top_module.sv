module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always @(*) begin
	case(state)
		2'b00: begin // State A
			next_state = in ? 2'b01 : 2'b00; // if in=1 -> B, if in=0 -> A
			out = 1'b0; // Output for state A is 0
		end
		2'b01: begin // State B
			next_state = in ? 2'b01 : 2'b10; // if in=1 -> B, if in=0 -> C
			out = 1'b0; // Output for state B is 0
		end
		2'b10: begin // State C
			next_state = in ? 2'b11 : 2'b00; // if in=1 -> D, if in=0 -> A
			out = 1'b0; // Output for state C is 0
		end
		2'b11: begin // State D
			next_state = in ? 2'b01 : 2'b10; // if in=1 -> B, if in=0 -> C
			out = 1'b1; // Output for state D is 1
		end
		default: begin
			next_state = 2'b00; // Default to state A
			out = 1'b0; // Default output is 0
		end
	endcase
end

endmodule
