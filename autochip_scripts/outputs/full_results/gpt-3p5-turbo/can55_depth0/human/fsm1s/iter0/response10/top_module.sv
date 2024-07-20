module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	reg state, next_state;

	parameter B = 0;
	parameter A = 1;

	always @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		case (state)
			B: begin
				if (in == 0) begin
					next_state = A;
				end else begin
					next_state = B;
				end
				out = 1;
			end
			A: begin
				if (in == 0) begin
					next_state = B;
				end else begin
					next_state = A;
				end
				out = 0;
			end
		endcase
	end

endmodule
