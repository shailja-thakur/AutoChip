module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] state, next_state;
	
	// State encoding
	localparam IDLE = 3'd0, SHIFT1 = 3'd1, SHIFT2 = 3'd2, SHIFT3 = 3'd3, SHIFT4 = 3'd4;

	// State transition
	always @(posedge clk) begin
		if (reset) 
			state <= SHIFT1;
		else 
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			SHIFT1: next_state = SHIFT2;
			SHIFT2: next_state = SHIFT3;
			SHIFT3: next_state = SHIFT4;
			SHIFT4: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			shift_ena <= 1'b1;
		else if (state == IDLE)
			shift_ena <= 1'b0;
		else
			shift_ena <= 1'b1;
	end

endmodule
