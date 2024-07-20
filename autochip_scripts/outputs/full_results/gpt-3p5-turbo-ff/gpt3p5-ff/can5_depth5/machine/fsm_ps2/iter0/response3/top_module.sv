module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define the states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define the state register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1; // Initialize state to BYTE1
	end else begin
		case (state)
			BYTE1: begin
				if (in[2]) begin // Check the third bit of the input
					state <= BYTE2; // Transition to BYTE2 if the third bit is 1
				end
			end

			BYTE2: begin
				state <= BYTE3; // Transition to BYTE3
			end

			BYTE3: begin
				state <= DONE; // Transition to DONE
			end

			DONE: begin
				if (in[2]) begin // Check the third bit of the input again
					state <= BYTE2; // Transition to BYTE2 if the third bit is 1
				end else begin
					state <= BYTE1; // Transition to BYTE1 if the third bit is 0
				end
			end
		endcase
	end
end

// Output done signal when the state machine is in the DONE state
assign done = (state == DONE);

endmodule
