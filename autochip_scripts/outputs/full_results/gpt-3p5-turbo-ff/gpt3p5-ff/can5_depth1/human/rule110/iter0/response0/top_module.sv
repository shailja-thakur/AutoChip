module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Set the boundaries to zero
			q[0] = 0;
			q[511] = 0;
			
			// Compute the next state for each cell
			for (int i = 1; i < 511; i = i + 1) begin
				if (q[i-1] == 1 && q[i] == 1 && q[i+1] == 1) begin
					q[i] = 0;
				end else if (q[i-1] == 1 && q[i] == 1 && q[i+1] == 0) begin
					q[i] = 1;
				end else if (q[i-1] == 1 && q[i] == 0 && q[i+1] == 1) begin
					q[i] = 1;
				end else if (q[i-1] == 1 && q[i] == 0 && q[i+1] == 0) begin
					q[i] = 0;
				end else if (q[i-1] == 0 && q[i] == 1 && q[i+1] == 1) begin
					q[i] = 1;
				end else if (q[i-1] == 0 && q[i] == 1 && q[i+1] == 0) begin
					q[i] = 1;
				end else if (q[i-1] == 0 && q[i] == 0 && q[i+1] == 1) begin
					q[i] = 1;
				end else if (q[i-1] == 0 && q[i] == 0 && q[i+1] == 0) begin
					q[i] = 0;
				end
			end
		end
	end
	
endmodule
