module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: if (j) state <= 1;
				1: if (k) state <= 0;
				default: state <= 0;
			endcase
		end
	end

	always @* begin
		if (state)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule
