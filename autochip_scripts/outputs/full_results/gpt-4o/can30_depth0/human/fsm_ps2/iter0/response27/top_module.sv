module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State definitions
	typedef enum reg [1:0] {
		IDLE,     // Waiting for first byte
		BYTE1,    // Received first byte
		BYTE2,    // Received second byte
		BYTE3     // Received third byte
	} state_t;
	
	state_t state, next_state;

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: next_state = (in[3] == 1) ? BYTE1 : IDLE;
			BYTE1: next_state = BYTE2;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = (in[3] == 1) ? BYTE1 : IDLE;
			default: next_state = IDLE;
		endcase
	end

	// State transition and output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
		end else begin
			state <= next_state;
			if (state == BYTE3) begin
				done <= 1;
			end else begin
				done <= 0;
			end
		end
	end

endmodule
