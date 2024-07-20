module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum reg [1:0] {IDLE, BYTE_1, BYTE_2, BYTE_3} state_t;
	state_t state, next_state;

	// State transition
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (in[3] == 1) begin
					next_state = BYTE_1;  // Start of a new message
				end else begin
					next_state = IDLE;  // Ignore the byte
				end
			end
			BYTE_1: begin
				next_state = BYTE_2;
			end
			BYTE_2: begin
				next_state = BYTE_3;
			end
			BYTE_3: begin
				next_state = IDLE;  // Go back to IDLE after the third byte
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			done <= 1'b0;
		end else begin
			case (state)
				IDLE: done <= 1'b0;
				BYTE_1: done <= 1'b0;
				BYTE_2: done <= 1'b0;
				BYTE_3: done <= 1'b1;  // Signal 'done' after the third byte
				default: done <= 1'b0;
			endcase
		end
	end
endmodule
