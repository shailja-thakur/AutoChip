module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);
	// State declarations
	typedef enum reg [1:0] {
		IDLE,      // Waiting for in[3] = 1
		BYTE1,     // Received the first byte
		BYTE2,     // Received the second byte
		BYTE3      // Received the third byte
	} state_t;
	state_t state, next_state;

	// Registers to store incoming bytes
	reg [7:0] byte1, byte2, byte3;

	// Sequential logic to update state and output registers
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			done <= 1'b0;
			out_bytes <= 24'b0;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
		end else begin
			state <= next_state;

			case (next_state)
				BYTE1: byte1 <= in;
				BYTE2: byte2 <= in;
				BYTE3: byte3 <= in;
			endcase
		end
	end

	// Combinational logic to determine the next state and outputs
	always @(*) begin
		// Set default values
		next_state = state;
		done = 1'b0;
		case (state)
			IDLE: begin
				if (in[3] == 1'b1) begin
					next_state = BYTE1;
				end
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = IDLE;
				done = 1'b1;
				out_bytes = {byte1, byte2, byte3};
			end
		endcase
	end
endmodule
