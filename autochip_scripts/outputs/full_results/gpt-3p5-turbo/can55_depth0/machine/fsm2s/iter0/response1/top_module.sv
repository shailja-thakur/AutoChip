module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or negedge reset) begin
	if (reset == 0) begin
		state <= 0;
		out <= 0;
	end else begin
		if (state == 0) begin
			if (j == 1) begin
				// transition from A to B
				state <= 1;
				out <= 1;
			end else begin
				// remain in state A
				state <= 0;
				out <= 0;
			end
		end else begin  // state == 1
			if (k == 1) begin
				// transition from B to A
				state <= 0;
				out <= 0;
			end else begin
				// remain in state B
				state <= 1;
				out <= 1;
			end
		end
	end
end

endmodule
