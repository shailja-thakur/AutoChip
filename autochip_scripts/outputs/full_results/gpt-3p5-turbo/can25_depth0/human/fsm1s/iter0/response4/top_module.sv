module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	reg state;

	always @(posedge clk) begin
		if (reset) begin
			state <= B;
			out <= 1;
		end else begin
			case (state)
				B: begin
					if (in)
						state <= B;
					else begin
						state <= A;
						out <= 1;
					end
				end
				A: begin
					if (in)
						state <= A;
					else begin
						state <= B;
						out <= 0;
					end
				end
			endcase
		end
	end
endmodule
