module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	reg state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			if (state == A) begin
				if (j) begin
					state <= B;
				end else begin
					state <= A;
				end
			end else begin // state == B
				if (k) begin
					state <= A;
				end else begin
					state <= B;
				end
			end
		end
	end

	assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
