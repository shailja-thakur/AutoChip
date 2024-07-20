module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

// state A: If s is asserted, next state is B
assign next_state = (state == 0 && s) ? 1 :

// state B: If w is asserted, next state is S11, otherwise next state is S10
(state == 1 && w) ? 3 : 2;

// state C: If w is asserted, next state is S11, otherwise next state is S10
assign next_state = (state == 2 && w) ? 3 : 2;

// state S10: If w is asserted, next state is S21, otherwise next state is S20
assign next_state = (state == 3 && w) ? 5 : 4;

// state S11: If w is asserted, next state is S22, otherwise next state is S21
assign next_state = (state == 4 && w) ? 6 : 5;

// state S20: next state is B
assign next_state = 1;

// state S21: If w is asserted, next state is C, otherwise next state is B
assign next_state = (state == 5 && w) ? 2 : 1;

// state S22: If w is asserted, next state is B, otherwise next state is C
assign next_state = (state == 6 && w) ? 1 : 2;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 0;
	else
		state <= next_state;
end

always @(posedge clk) begin
	if (state == 6)
		z <= 1;
	else
		z <= 0;
end

endmodule
