module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter INITIAL_STATE = 1'b0;  // Initial state B
reg state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= INITIAL_STATE;
	end else begin
		if (state == 1'b0) begin  // Current state is B
			if (in) begin
				state <= 1'b0;  // Next state is B
			end else begin
				state <= 1'b1;  // Next state is A
			end
		end else begin  // Current state is A
			if (in) begin
				state <= 1'b1;  // Next state is A
			end else begin
				state <= 1'b0;  // Next state is B
			end
		end
	end
end

assign out = state;

endmodule
