module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] state, next_state;
	localparam IDLE = 3'b000, SHIFT_1 = 3'b001, SHIFT_2 = 3'b010, SHIFT_3 = 3'b011, SHIFT_4 = 3'b100;

	always @(posedge clk) begin
		if (reset)
			state <= SHIFT_1;
		else
			state <= next_state;
	end

	always @(*) begin
		case(state)
			IDLE: next_state = IDLE;
			SHIFT_1: next_state = SHIFT_2;
			SHIFT_2: next_state = SHIFT_3;
			SHIFT_3: next_state = SHIFT_4;
			SHIFT_4: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	always @(posedge clk) begin
		if (reset)
			shift_ena <= 1;
		else if (state == SHIFT_4)
			shift_ena <= 0;
		else if (state != IDLE)
			shift_ena <= 1;
		else
			shift_ena <= 0;
	end

endmodule
