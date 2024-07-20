module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk or posedge reset) begin
		if(reset)
			q <= 32'h1;
		else begin
			q[0] <= q[1] ^ q[2] ^ q[21] ^ q[31];
			q[1] <= q[0];
			for(int i=2; i<31; i=i+1)
				q[i] <= q[i+1];
			q[31] <= q[0];
		end
	end

endmodule
