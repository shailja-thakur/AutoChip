module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum reg [2:0] {
		IDLE    = 3'b000,
		S1      = 3'b001,
		S11     = 3'b010,
		S110    = 3'b011,
		S1101   = 3'b100
	} state_t;

	// Current state and next state variables
	reg [2:0] current_state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			start_shifting <= 1'b0;
		end else begin
			current_state <= next_state;
		end
	end

	// State transition logic
	always @(*) begin
		case (current_state)
			IDLE: begin
				if (data == 1'b1)
					next_state = S1;
				else
					next_state = IDLE;
			end
			S1: begin
				if (data == 1'b1)
					next_state = S11;
				else
					next_state = IDLE;
			end
			S11: begin
				if (data == 1'b0)
					next_state = S110;
				else
					next_state = S11;
			end
			S110: begin
				if (data == 1'b1)
					next_state = S1101;
				else
					next_state = IDLE;
			end
			S1101: begin
				next_state = S1101;  // Remain in this state once sequence is found
			end
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (current_state == S1101)
			start_shifting <= 1'b1;
	end
endmodule
