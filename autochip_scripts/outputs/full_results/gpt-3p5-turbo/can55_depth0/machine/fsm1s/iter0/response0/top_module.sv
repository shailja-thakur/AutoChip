module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg state;
parameter A = 0;
parameter B = 1;

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
		end else begin
			if (in) begin
				state <= B;
			end else begin
				state <= A;
			end
		end
	end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
