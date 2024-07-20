module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;
	parameter A = 2'b00;
	parameter B = 2'b01;

	always @(posedge clk) begin
		if (reset)
			state <= A;
		else if (state == A)
			state <= (j) ? B : A;
		else if (state == B)
			state <= (k) ? A : B;
	end

	always @(state) begin
		out <= (state == B) ? 1'b1 : 1'b0;
	end

endmodule
