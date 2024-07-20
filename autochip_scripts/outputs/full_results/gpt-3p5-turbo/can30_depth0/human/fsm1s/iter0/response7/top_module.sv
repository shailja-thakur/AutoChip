module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;
	parameter B = 0;
	parameter A = 1;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
			out <= 1;
		end
		else begin
			if (state == B) begin
				if (in) begin
					state <= B;
					out <= 1;
				end
				else begin
					state <= A;
					out <= 0;
				end
			end
			else if (state == A) begin
				if (in) begin
					state <= A;
					out <= 0;
				end
				else begin
					state <= B;
					out <= 1;
				end
			end
		end
	end

endmodule
