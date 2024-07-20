module top_module(
	input wire clk,
	input wire L,
	input wire q_in,
	input wire r_in,
	output reg Q);

	always @(posedge clk) begin
		if (L == 1'b1)
			Q <= r_in;
		else
			Q <= q_in;
	end

	initial begin
		Q <= 1'b0;
	end
	
endmodule
