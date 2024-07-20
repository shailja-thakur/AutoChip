module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);
	
	// Declare internal state variables
	reg [1:0] state;
	
	// Assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // BYTE1 state
		else
			state <= state; // Hold current state
	end
	
	// State machine logic
	always @(posedge clk) begin
		case (state)
			2'b00: begin // BYTE1 state
				if (in[2] == 1)
					state <= 2'b01; // BYTE2 state
				else
					state <= 2'b00; // Remain in BYTE1 state
			end
			2'b01: begin // BYTE2 state
				state <= 2'b10; // BYTE3 state
			end
			2'b10: begin // BYTE3 state
				state <= 2'b11; // DONE state
			end
			2'b11: begin // DONE state
				if (in[2] == 1)
					state <= 2'b01; // Transition back to BYTE2 state
				else
					state <= 2'b00; // Transition back to BYTE1 state
			end
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		if (state == 2'b11) // DONE state
			done <= 1'b1;
		else
			done <= 1'b0;
	end
	
endmodule
