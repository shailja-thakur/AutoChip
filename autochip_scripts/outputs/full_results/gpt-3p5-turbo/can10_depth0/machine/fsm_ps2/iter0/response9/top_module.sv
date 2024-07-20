module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states using a 2-bit register
	reg [1:0] state;
	
	// Register to store previous value of the third bit
	reg prev_bit;
	
	// Assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // BYTE1 state
		else
			state <= state; // Remain in the current state
	end
	
	// State transition and output logic
	always @(posedge clk) begin
		case (state)
			2'b00: begin // BYTE1 state
				if (in[2] == 1'b1)
					state <= 2'b01; // Transition to BYTE2 state
				else
					state <= 2'b00; // Remain in the BYTE1 state
			end
			
			2'b01: begin // BYTE2 state
				state <= 2'b10; // Transition to BYTE3 state
			end
			
			2'b10: begin // BYTE3 state
				state <= 2'b11; // Transition to DONE state
			end
			
			2'b11: begin // DONE state
				if (in[2] == 1'b0)
					state <= 2'b00; // Transition to BYTE1 state
				else
					state <= 2'b01; // Transition to BYTE2 state
			end
		endcase
	end
	
	// Output logic
	assign done = (state == 2'b11);
	
endmodule
