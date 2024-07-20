module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	if (a && b) begin
		state <= 1; // Set state to 1 when both a and b are 1
		q <= 1;
	end
	else if (a && !b) begin
		state <= 0; // Set state to 0 when a is 1 and b is 0
		q <= 0;
	end
	else if (!a && b) begin
		state <= ~state; // Toggle state when a is 0 and b is 1
		q <= state;
	end
	else begin
		state <= state; // Maintain current state when a and b are both 0
		q <= state;
	end
end

endmodule
