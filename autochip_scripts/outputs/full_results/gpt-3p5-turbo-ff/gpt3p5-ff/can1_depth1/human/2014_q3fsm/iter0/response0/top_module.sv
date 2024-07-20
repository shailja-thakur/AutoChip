module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state; // state variable to keep track of the current state

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= 2'b00; // initialize state to 00 (reset state A)
	else if (state == 2'b00) begin
		if (s == 1'b1) begin
			state <= 2'b01; // transition to state B
		end
	else if (state == 2'b01) begin
		state <= 2'b10; // transition to state C
	else if (state == 2'b10) begin
		state <= 2'b11; // transition to state D
	else if (state == 2'b11) begin
		if (w == 1'b1) begin
			state <= 2'b10; // transition back to state C
			z <= 1'b1; // set output z to 1
		else begin
			state <= 2'b00; // transition back to state A
			z <= 1'b0; // set output z to 0
		end
	end
end

endmodule
