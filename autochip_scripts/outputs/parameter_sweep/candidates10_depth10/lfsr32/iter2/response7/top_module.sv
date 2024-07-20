module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] new_q;
	wire tap;

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			new_q = {q[30:0], tap};
			q <= new_q;
		end
	end

	assign tap = q[22]^q[2]^q[1];
endmodule
