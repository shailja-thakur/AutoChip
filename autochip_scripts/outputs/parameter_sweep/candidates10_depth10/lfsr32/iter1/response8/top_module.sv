module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [0:31] taps = 32'b10000000000000000000100000000001;
	reg [0:31] temp_q;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			temp_q = {q[30:0], q[22]^q[1]};
			q <= temp_q ^ (q & taps);
		end
	end
endmodule
