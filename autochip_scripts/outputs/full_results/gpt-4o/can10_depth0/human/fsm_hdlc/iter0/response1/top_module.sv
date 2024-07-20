module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [2:0] {
		IDLE, S1, S2, S3, S4, S5, S6, FLAGGING, ERROR
	} state_t;

	state_t current_state, next_state;
	
	// Actual bit counter
	reg [2:0] bit_count;

	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
			bit_count <= 3'd0;
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end else begin
			current_state <= next_state;
			if (current_state == S5 && in == 1'b0) disc <= 1'b1;
			else disc <= 1'b0;
			
			if ((current_state == S6 && in == 1'b0) || (current_state == FLAGGING && bit_count == 3'd6)) flag <= 1'b1;
			else flag <= 1'b0;
	
			if (current_state == ERROR) err <= 1'b1;
			else err <= 1'b0;
		end
	end

	always_comb begin
		case (current_state)
			IDLE: next_state = in ? S1 : IDLE;
			S1: next_state = in ? S2 : IDLE;
			S2: next_state = in ? S3 : IDLE;
			S3: next_state = in ? S4 : IDLE;
			S4: next_state = in ? S5 : IDLE;
			S5: begin
				if (in) next_state = S6;
				else next_state = IDLE;
			end
			S6: begin
				if (in) begin
					next_state = ERROR;
				end else begin
					next_state = FLAGGING; // transition to flagging state, temporary state
				end
			end
			FLAGGING: next_state = bit_count == 3'd6 ? IDLE : FLAGGING; // stay in flagging until we complete the cycle
			ERROR: next_state = ERROR; // stay in error state
			default: next_state = IDLE;
		endcase
	end

	always_ff @(posedge clk) begin
		if (reset) bit_count <= 3'd0;
		else if (current_state == FLAGGING) bit_count <= bit_count + 3'd1;
		else bit_count <= 3'd0;
	end

endmodule
