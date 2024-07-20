module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;
	parameter B = 2'd0;
	parameter A = 2'd1;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
			out <= 1;
		end else begin
			case (state)
				B:
					if (in) begin
						state <= B;
						out <= 1;
					end else begin
						state <= A;
						out <= 0;
					end
				A:
					if (in) begin
						state <= A;
						out <= 0;
					end else begin
						state <= B;
						out <= 1;
					end
			endcase
		end
	end
endmodule
