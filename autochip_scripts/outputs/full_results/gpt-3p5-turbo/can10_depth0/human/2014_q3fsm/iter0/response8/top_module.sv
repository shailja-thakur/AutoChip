module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else if (s == 1'b0) // Transition from A to B
		state <= 2'b01;
	else if (s == 1'b1 && state == 2'b01) begin // Check w in state B
		if (w == 1'b1)
			state <= 2'b10;
		else
			state <= 2'b01;
	end else if (state == 2'b10) begin // Set output z in the following clock cycle
		if (w == 1'b1)
			state <= 2'b11;
		else
			state <= 2'b00;
	end else if (state == 2'b11) begin // Continue checking w for the next three cycles
		state <= 2'b00;
	end
end

always @(posedge clk) begin
	if (state == 2'b11)
		z <= 1'b1;
	else
		z <= 1'b0;
end

endmodule
