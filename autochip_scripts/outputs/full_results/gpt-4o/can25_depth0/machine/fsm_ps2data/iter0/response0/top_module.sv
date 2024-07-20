module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State definitions
	typedef enum reg [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t current_state, next_state;
	reg [23:0] shift_reg;

	// State machine: state transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			current_state <= next_state;
			if (current_state == BYTE1 || current_state == BYTE2 || current_state == BYTE3) begin
				shift_reg <= {shift_reg[15:0], in};
			end else if (current_state == DONE) begin
				out_bytes <= shift_reg;
			end
		end
	end

	// State machine: next state logic
	always @(*) begin
		done = 1'b0; // Default value
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
				if (!in[2])
					next_state = BYTE1;
				else
					next_state = DONE;
			end

			default: begin
				next_state = BYTE1;
			end
		endcase
	end

endmodule
