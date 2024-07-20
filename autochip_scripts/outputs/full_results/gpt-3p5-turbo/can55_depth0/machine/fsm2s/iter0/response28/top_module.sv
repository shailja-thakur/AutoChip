module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg state, next_state;
	 
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	 
	always @(*) begin
		case (state)
			A: begin
				if (j) begin
					next_state = B;
				end else begin
					next_state = A;
				end
				out = 0;
			end
			B: begin
				if (k) begin
					next_state = A;
				end else begin
					next_state = B;
				end
				out = 1;
			end
		endcase
	end
endmodule
