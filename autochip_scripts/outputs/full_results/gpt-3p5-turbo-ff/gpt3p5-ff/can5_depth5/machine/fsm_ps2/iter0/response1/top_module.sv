module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Define states
	typedef enum logic [1:0] {
		BYTE1,
		BYTE2,
		BYTE3,
		DONE
	} state_type;

	// Registers
	reg state_type current_state, next_state;
	reg done;

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
		end else begin
			current_state <= next_state;
		end
	end

	always_comb begin
		case (current_state)
			BYTE1:
				if (in[2] == 1'b1) begin
					next_state = BYTE2;
				end else begin
					next_state = BYTE1;
				end
			BYTE2:
				next_state = BYTE3;
			BYTE3:
				if (in[2] == 1'b1) begin
					next_state = DONE;
				end else begin
					next_state = BYTE1;
				end
			DONE:
				if (in[2] == 1'b1) begin
					next_state = BYTE2;
				end else begin
					next_state = BYTE1;
				end
		endcase
	end

	always_comb begin
		done = (current_state == DONE);
	end

endmodule
