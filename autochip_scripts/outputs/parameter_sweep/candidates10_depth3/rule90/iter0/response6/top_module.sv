module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end
		else begin
			q[0] <= q[1] ^ q[511]; // Boundary condition
			for (int i = 1; i < 511; i = i + 1) begin
				q[i] <= q[i-1] ^ q[i+1];
			end
			q[511] <= q[510] ^ q[0]; // Boundary condition
		end
	end

endmodule
