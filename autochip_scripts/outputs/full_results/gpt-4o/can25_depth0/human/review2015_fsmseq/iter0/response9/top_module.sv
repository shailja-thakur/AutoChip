module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	typedef enum reg [2:0] {
		STATE_IDLE = 3'b000,
		STATE_1    = 3'b001,
		STATE_11   = 3'b010,
		STATE_110  = 3'b011,
		STATE_1101 = 3'b100
	} state_t;

	reg [2:0] state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			STATE_IDLE: next_state = data ? STATE_1 : STATE_IDLE;
			STATE_1:    next_state = data ? STATE_11 : STATE_IDLE;
			STATE_11:   next_state = data ? STATE_11 : STATE_110;
			STATE_110:  next_state = data ? STATE_1101 : STATE_IDLE;
			STATE_1101: next_state = STATE_1101;
			default:    next_state = STATE_IDLE;
		endcase
	end

	// State flip-flops (sequential)
	always @(posedge clk) begin
		if (reset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == STATE_1101)
			start_shifting <= 1'b1;
	end

endmodule
