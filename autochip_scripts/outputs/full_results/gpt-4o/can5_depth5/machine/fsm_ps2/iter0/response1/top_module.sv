module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

// State encoding
typedef enum reg [1:0] {
	BYTE1 = 2'b00,
	BYTE2 = 2'b01,
	BYTE3 = 2'b10,
	DONE  = 2'b11
} state_t;

// Current state and next state variables
state_t current_state, next_state;

// State transition and output logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= BYTE1;
		done <= 1'b0;
	end else begin
		current_state <= next_state;
	end
end

always @(*) begin
	// Default values for next state and output
	next_state = current_state;
	done = 1'b0;

	case (current_state)
		BYTE1: begin
			if (in[2])
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
			done = 1'b1;
			if (in[2])
				next_state = BYTE2;
			else
				next_state = BYTE1;
		end

		default: begin
			next_state = BYTE1;
		end
	endcase
end

endmodule
