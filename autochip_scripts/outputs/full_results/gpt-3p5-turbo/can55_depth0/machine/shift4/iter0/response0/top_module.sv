module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	// internal wire declaration
	reg [3:0] reg_temp;

	always @(posedge clk or posedge areset) begin
		if (areset == 1) begin
			q <= 0;
		end else begin
			if (load == 1) begin
				q <= data;
			end else begin
				if (ena == 1) begin
					reg_temp[3:1] <= q[2:0];
					reg_temp[0] <= 0;
					q <= reg_temp;
				end
			end
		end
	end
endmodule
