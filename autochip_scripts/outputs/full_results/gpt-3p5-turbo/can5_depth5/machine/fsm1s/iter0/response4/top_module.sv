module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 0;
parameter B = 1;

reg state;

always @(posedge clk) begin
	if (reset) begin
		state <= B;
	end else begin
		if (state == A) begin
			if (in) begin
				state <= A;
			end else begin
				state <= B;
			end
		end else if (state == B) begin
			if (in) begin
				state <= B;
			end else begin
				state <= A;
			end
		end
	end
end

assign out = state;

endmodule
