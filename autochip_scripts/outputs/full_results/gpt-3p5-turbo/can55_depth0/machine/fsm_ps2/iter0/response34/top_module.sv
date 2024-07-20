module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State definition
reg [1:0] state;

// Next state logic
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00; // Initial state: BYTE1
	else begin
		case (state)
			2'b00: // BYTE1 state
				if (in[2]) // Check third bit of input
					state <= 2'b01; // Transition to BYTE2
				else
					state <= 2'b00; // Remain in BYTE1
			2'b01: // BYTE2 state
				state <= 2'b10; // Transition to BYTE3
			2'b10: // BYTE3 state
				state <= 2'b11; // Transition to DONE
			2'b11: // DONE state
				if (in[2]) // Check third bit of input
					state <= 2'b01; // Transition to BYTE2
				else
					state <= 2'b00; // Transition to BYTE1
		endcase
	end
end

// Output logic
assign done = (state == 2'b11); // Assert done signal when in DONE state

endmodule
