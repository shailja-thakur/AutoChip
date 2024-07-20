module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 0;
		end else begin
			if (load) begin
				q <= data;
			end else begin
				if (ena) begin
					q[3] <= 0;
					q[0] <= q[1];
					q[1] <= q[2];
					q[2] <= q[3];
					q[3] <= ena;
				end
			end
		end
	end
	
endmodule
