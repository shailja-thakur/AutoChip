module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define state names
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Declare internal state register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1; // Reset state to BYTE1
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1) begin
					state <= BYTE2; // Transition to BYTE2 state
				end else begin
					state <= BYTE1; // Remain in BYTE1 state
				end
			end

			BYTE2: begin
				state <= BYTE3; // Transition to BYTE3 state
			end

			BYTE3: begin
				state <= DONE; // Transition to DONE state
			end

			DONE: begin
				if (in[2] == 1) begin
					state <= BYTE2; // Transition to BYTE2 state
				end else begin
					state <= BYTE1; // Transition back to BYTE1 state
				end
			end
		endcase
	end
end

assign done = (state == DONE); // Assert done signal when in the DONE state

endmodule
