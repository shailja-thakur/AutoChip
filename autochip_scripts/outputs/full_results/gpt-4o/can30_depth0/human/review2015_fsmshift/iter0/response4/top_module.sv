module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] state;
	reg [2:0] next_state;

	localparam S_IDLE = 3'b000;
	localparam S_SHIFT1 = 3'b001;
	localparam S_SHIFT2 = 3'b010;
	localparam S_SHIFT3 = 3'b011;
	localparam S_SHIFT4 = 3'b100;

	// State transition logic
	always @(*) begin
		case (state)
			S_IDLE: next_state = reset ? S_SHIFT1 : S_IDLE;
			S_SHIFT1: next_state = S_SHIFT2;
			S_SHIFT2: next_state = S_SHIFT3;
			S_SHIFT3: next_state = S_SHIFT4;
			S_SHIFT4: next_state = S_IDLE;
			default: next_state = S_IDLE;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= S_SHIFT1;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			shift_ena <= 1;
		else if (state == S_SHIFT4)
			shift_ena <= 0;
		else
			shift_ena <= shift_ena;
	end

endmodule
