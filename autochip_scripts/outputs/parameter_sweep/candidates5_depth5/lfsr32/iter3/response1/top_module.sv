module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] nxt_q;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end
		else begin
			q <= nxt_q;
		end
	end
	
	always @* begin
		nxt_q[31] = q[21] ^ q[1] ^ q[0];
		nxt_q[30:0] = q[29:0];
	end
	
endmodule
