module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [2:0] {
		STATE_000 = 3'b000,
		STATE_001 = 3'b001,
		STATE_010 = 3'b010,
		STATE_011 = 3'b011,
		STATE_100 = 3'b100
	} state_t;

	reg [2:0] current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			STATE_000: next_state = (x == 1) ? STATE_001 : STATE_000;
			STATE_001: next_state = (x == 1) ? STATE_100 : STATE_001;
			STATE_010: next_state = (x == 1) ? STATE_001 : STATE_010;
			STATE_011: next_state = (x == 1) ? STATE_010 : STATE_001;
			STATE_100: next_state = (x == 1) ? STATE_100 : STATE_011;
			default: next_state = STATE_000;
		endcase
	end

	// State register
	always @(posedge clk) begin
		if (reset)
			current_state <= STATE_000;
		else
			current_state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (current_state)
			STATE_000: z = 1'b0;
			STATE_001: z = 1'b0;
			STATE_010: z = 1'b0;
			STATE_011: z = 1'b1;
			STATE_100: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
