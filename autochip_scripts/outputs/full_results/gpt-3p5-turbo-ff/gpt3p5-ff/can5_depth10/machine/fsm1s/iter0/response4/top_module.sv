module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter STATE_A = 1'b0;
	parameter STATE_B = 1'b1;
	reg state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= STATE_B;
		end else begin
			if (state == STATE_A) begin
				if (in) begin
					state <= STATE_A;
				end else begin
					state <= STATE_B;
				end
			end else begin
				if (in) begin
					state <= STATE_B;
				end else begin
					state <= STATE_A;
				end
			end
		end
	end
	
	assign out = state;

endmodule
