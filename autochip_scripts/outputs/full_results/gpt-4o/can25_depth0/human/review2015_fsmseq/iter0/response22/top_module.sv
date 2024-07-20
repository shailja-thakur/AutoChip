module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	typedef enum reg [2:0] {
		IDLE = 3'd0,
		S1   = 3'd1,
		S2   = 3'd2,
		S3   = 3'd3,
        S4   = 3'd4
	} state_t;

	state_t state, next_state;

	// State Transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (data)
					next_state = S1;
				else
					next_state = IDLE;
			end
			S1: begin
				if (data)
					next_state = S2;
				else
					next_state = IDLE;
			end
			S2: begin
				if (data)
					next_state = S3;
				else
					next_state = IDLE;
			end
			S3: begin
				if (data)
					next_state = S3;
				else
					next_state = S4;
			end
            S4: begin
                if (data)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == S4 && data == 1'b0)
			start_shifting <= 1'b1;
	end

endmodule
