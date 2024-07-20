module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Definitions
	typedef enum reg [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_t;
	state_t state, next_state;

	// Shift register
	reg [23:0] shift_reg;

	// Reset the state machine and other registers
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			shift_reg <= 24'b0;
			done <= 1'b0;
			out_bytes <= 24'b0;
		end else begin
			state <= next_state;

			if (state != DONE) begin
				shift_reg <= {shift_reg[15:0], in};
			end

			if (next_state == DONE && state != DONE) begin
				done <= 1;
			end else begin
				done <= 0;
			end

			if (next_state == BYTE1 && state == DONE) begin
				shift_reg <= 24'b0;
			end
		end
	end

	// Next state logic 
	always @(*) begin
		case(state)
			BYTE1: begin
				if (in[2] == 1) next_state = BYTE2;
				else next_state = BYTE1;
			end
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = BYTE1;
		endcase
	end

	// Update the out_bytes output when done
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 24'b0;
		end else if (done) begin
			out_bytes <= shift_reg;
		end
	end

endmodule
