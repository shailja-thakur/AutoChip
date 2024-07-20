module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Declare state register
reg [1:0] state;

// Declare next state register
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// Reset state machine to initial state
		state <= 2'b00;
	end else begin
		// Assign next state based on current state and input
		case(state)
			2'b00: begin // BYTE1 state
				if (in[2] == 1'b1) begin
					next_state <= 2'b01; // Transition to BYTE2 state
				end else begin
					next_state <= 2'b00; // Remain in BYTE1 state
				end
			end
			
			2'b01: begin // BYTE2 state
				next_state <= 2'b10; // Transition to BYTE3 state
			end
			
			2'b10: begin // BYTE3 state
				next_state <= 2'b11; // Transition to DONE state
			end
			
			2'b11: begin // DONE state
				if (in[2] == 1'b1) begin
					next_state <= 2'b01; // Transition to BYTE2 state
				end else begin
					next_state <= 2'b00; // Transition to BYTE1 state
				end
			end
		endcase
	end
end

// Assign current state from next state
always @(posedge clk) begin
	state <= next_state;
end

// Output done signal when in the DONE state
assign done = (state == 2'b11);

endmodule
