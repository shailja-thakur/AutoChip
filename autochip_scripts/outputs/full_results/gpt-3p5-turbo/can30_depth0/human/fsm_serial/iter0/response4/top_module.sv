module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	// Define the states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	// Define the signals
	reg done;
	reg [2:0] state;
	reg [7:0] data;

	// Define the FSM
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset to IDLE state
			state <= IDLE;
			data <= 8'b0;
			done <= 0;
		end else begin
			case (state)
				IDLE:
					if (in == 1'b0) begin
						// Start bit detected, transition to START_BIT state
						state <= START_BIT;
						data <= 8'b0;
						done <= 0;
					end
				START_BIT:
					if (in == 1'b0) begin
						// Continue to receive data bits
						state <= DATA_BITS;
						data <= {data[6:0], in};
						done <= 0;
					end else if (in == 1'b1) begin
						// Start bit invalid, return to IDLE state
						state <= IDLE;
						data <= 8'b0;
						done <= 0;
					end
				DATA_BITS:
					if (in == 1'b1) begin
						// Store data bits
						data <= {data[6:0], in};
						done <= 0;
					end else if (in == 1'b0) begin
						// Stop bit detected, transition to STOP_BIT state
						state <= STOP_BIT;
						done <= 0;
					end
				STOP_BIT:
					if (in == 1'b1) begin
						// Stop bit valid, byte received
						state <= IDLE;
						done <= 1;
					end else if (in == 1'b0) begin
						// Stop bit invalid, wait for stop bit
						done <= 0;
					end
			endcase
		end
	end
endmodule
