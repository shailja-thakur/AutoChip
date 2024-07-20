module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q[511] <= 0;
			for (int i = 510; i >= 0; i = i - 1) begin
				if (q[i+1] && q[i] && q[i-1]) begin
					q[i] <= 0;
				end else if (q[i+1] && q[i] && !q[i-1]) begin
					q[i] <= 1;
				end else if (q[i+1] && !q[i] && q[i-1]) begin
					q[i] <= 1;
				end else if (q[i+1] && !q[i] && !q[i-1]) begin
					q[i] <= 0;
				end else if (!q[i+1] && q[i] && q[i-1]) begin
					q[i] <= 1;
				end else if (!q[i+1] && q[i] && !q[i-1]) begin
					q[i] <= 1;
				end else if (!q[i+1] && !q[i] && q[i-1]) begin
					q[i] <= 1;
				end else if (!q[i+1] && !q[i] && !q[i-1]) begin
					q[i] <= 0;
				end
			end
			q[0] <= 0;
		end
	end

endmodule
