module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum logic [1:0] {
		BYTE1 = 2'd0,
		BYTE2 = 2'd1,
		BYTE3 = 2'd2,
		DONE = 2'd3
	} state_t;

	state_t current_state, next_state;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
		end
		else begin
			current_state <= next_state;
		end
	end

	always_comb begin
		next_state = current_state; // Default state is current state
		done = 1'b0; // Default done signal is de-asserted

		case (current_state)
			BYTE1: begin
				if (in[2] == 1'b1)
					next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				done = 1'b1;
				if (in[2] == 1'b0)
					next_state = BYTE1;
				else
					next_state = BYTE2;
			end
			default: begin
				next_state = BYTE1;
			end
		endcase
	end

endmodule
