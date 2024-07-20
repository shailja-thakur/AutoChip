module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// State definition
	typedef enum logic [1:0] {
		INIT,
		WAIT_START,
		WAIT_BYTE2,
		WAIT_BYTE3,
		DONE
	} state_t;

	// State and output signals
	state_t state, next_state;
	logic done_reg;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= INIT;
			done_reg <= 0;
		end else begin
			state <= next_state;
			done_reg <= (state == DONE) ? 1'b1 : 1'b0;
		end
	end

	always_comb begin
		// Default assignments
		next_state = state;

		case(state)
			INIT:
				if (in[3]) begin
					next_state = WAIT_START;
				end
			WAIT_START:
				if (in[3]) begin
					next_state = WAIT_BYTE2;
				end
			WAIT_BYTE2:
				if (in[3]) begin
					next_state = WAIT_BYTE3;
				end
			WAIT_BYTE3:
				if (in[3]) begin
					next_state = DONE;
				end
			DONE:
				next_state = INIT;
		endcase
	end

	assign done = done_reg;

endmodule
