module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State declarations
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		BYTE1 = 2'b01,
		BYTE2 = 2'b10,
		BYTE3 = 2'b11
	} state_t;

	// State and next state variables
	state_t state, next_state;

	// State transition and output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
		end else begin
			state <= next_state;
			// Output logic
			if (next_state == BYTE3 && state == BYTE2) begin
				done <= 1;
			end else begin
				done <= 0;
			end
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (in[3] == 1) begin
					next_state = BYTE1;
				end else begin
					next_state = IDLE;
				end
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				if (in[3] == 1) begin
					next_state = BYTE1;
				end else begin
					next_state = IDLE;
				end
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end
endmodule
