module top_module(
	input wire clk,
	input wire L,
	input wire q_in,
	input wire r_in,
	output reg Q);

reg prev_L;
always @(posedge clk) begin
	prev_L <= L;
	if(prev_L) begin
		Q <= r_in;
	end else begin
		Q <= q_in;
	end
end

endmodule
