module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State declaration
	typedef enum reg [1:0] {
		BYTE1 = 2'd0,
		BYTE2 = 2'd1,
		BYTE3 = 2'd2,
		DONE  = 2'd3
	} state_t;

	state_t state, next_state;

	// State transition on clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1; // Initialize to BYTE1 state on reset
		end else begin
			state <= next_state;
		end
	end

	// Define next state logic
	always @(*) begin
		case (state)
			BYTE1: begin
				if (in[2] == 1'b1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				if (in[2] == 1'b1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			default: next_state = BYTE1; // Default to BYTE1 state
		endcase
	end

	// Set done signal based on current state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			done <= 1'b0; // Reset done signal
		end else begin
			if (state == DONE)
				done <= 1'b1; // Assert done signal in DONE state
			else
				done <= 1'b0; // Deassert done signal in other states
		end
	end

endmodule
