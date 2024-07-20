module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

	reg [31:0] feedback;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else begin
			feedback[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
			feedback[1] <= q[0];
			feedback[2] <= q[31];
			feedback[3:31] <= q[2:30];
			q <= feedback;
		end
	end

endmodule
