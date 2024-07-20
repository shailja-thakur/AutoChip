module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	// Output logic based on the state
	assign out = (state == 2'b11) ? 1 : 0;

	// Next state logic based on current state and input
	always @(*) begin
		case (state)
			2'b00: begin // State A
				next_state = (in == 0) ? 2'b00 : 2'b01;
			end
			2'b01: begin // State B
				next_state = (in == 0) ? 2'b10 : 2'b01;
			end
			2'b10: begin // State C
				next_state = (in == 0) ? 2'b00 : 2'b11;
			end
			2'b11: begin // State D
				next_state = (in == 0) ? 2'b10 : 2'b01;
			end
			default: begin // Default should not happen but for safety
				next_state = 2'b00;
			end
		endcase
	end
	
endmodule
