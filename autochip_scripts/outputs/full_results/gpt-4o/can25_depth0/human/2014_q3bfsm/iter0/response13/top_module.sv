module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	// State encoding
	localparam STATE_000 = 3'b000;
	localparam STATE_001 = 3'b001;
	localparam STATE_010 = 3'b010;
	localparam STATE_011 = 3'b011;
	localparam STATE_100 = 3'b100;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_000: next_state = (x == 0) ? STATE_000 : STATE_001;
			STATE_001: next_state = (x == 0) ? STATE_001 : STATE_100;
			STATE_010: next_state = (x == 0) ? STATE_010 : STATE_001;
			STATE_011: next_state = (x == 0) ? STATE_001 : STATE_010;
			STATE_100: next_state = (x == 0) ? STATE_011 : STATE_100;
			default: next_state = STATE_000; //default case to reset state machine
		endcase
	end

	// State flip-flops with synchronous active-high reset
	always @(posedge clk) begin
		if (reset) 
			state <= STATE_000;
		else 
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_011, STATE_100: z = 1;
			default: z = 0;
		endcase
	end

endmodule
