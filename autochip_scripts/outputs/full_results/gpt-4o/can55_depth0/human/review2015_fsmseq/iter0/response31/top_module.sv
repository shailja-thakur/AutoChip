module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

    // Declare state names
	typedef enum reg [2:0] {
		IDLE = 3'b000,
		S1 = 3'b001,
		S2 = 3'b010,
		S3 = 3'b011,
		S4 = 3'b100
	} state_t;
	
    // State registers
	reg state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			IDLE:   next_state = data ? S1 : IDLE;
			S1:     next_state = data ? S2 : IDLE;
			S2:     next_state = data ? S2 : S3;
			S3:     next_state = data ? S4 : IDLE;
			S4:     next_state = S4;  // Stay in S4 forever once detected
			default: next_state = IDLE;  // Default case to IDLE
		endcase
	end

	// State register control logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 1'b0;
		end
		else begin
			state <= next_state;
			if (state == S4)
				start_shifting <= 1'b1;
		end
	end

endmodule
