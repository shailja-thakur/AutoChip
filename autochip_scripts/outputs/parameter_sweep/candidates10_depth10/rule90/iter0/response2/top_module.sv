module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= next_q;
		end
	end

	always @(q) begin
		next_q[0] = (q[1] & q[2]) ^ q[0];
		next_q[1] = (q[0] & q[2]) ^ q[1];
		for (i = 2; i < 511; i = i+1) begin
			next_q[i] = (q[i-1] & q[i+1]) ^ q[i];
		end
		next_q[511] = (q[510] & q[509]) ^ q[511];
	end

endmodule
