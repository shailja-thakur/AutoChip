module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	integer i;
	reg [511:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (i = 0; i < 512; i = i + 1) begin
				if (i == 0)
					next_q[i] = 1'b0 ^ q[i+1];
				else if (i == 511)
					next_q[i] = q[i-1] ^ 1'b0;
				else
					next_q[i] = q[i-1] ^ q[i+1];
			end
			q <= next_q;
		end
	end

endmodule
