module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Declare internal signal for the enable signals of the upper three digits
	reg [2:0] ena_internal;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena_internal <= 3'b000;
		end else begin
			// Increment the ones digit
			if (ena_internal[2]) begin
				if (q[3:0] == 4'b1001) begin
					q[3:0] <= 4'b0000;
					ena_internal[2] <= 1'b0;
				end else begin
					q[3:0] <= q[3:0] + 1;
				end
			end

			// Increment the tens digit
			if (ena_internal[1]) begin
				if (q[7:4] == 4'b1001) begin
					q[7:4] <= 4'b0000;
					ena_internal[1] <= 1'b0;
				end else begin
					q[7:4] <= q[7:4] + 1;
				end
			end

			// Increment the hundreds digit
			if (ena_internal[0]) begin
				if (q[11:8] == 4'b1001) begin
					q[11:8] <= 4'b0000;
					ena_internal[0] <= 1'b0;
				end else begin
					q[11:8] <= q[11:8] + 1;
				end
			end
			
			// Increment the thousands digit
			if (q[15:12] == 4'b1001) begin
				q[15:12] <= 4'b0000;
			end else begin
				q[15:12] <= q[15:12] + 1;
			end
		end
	end
	
	// Assign the output enable signals
	assign ena = ena_internal;
	
endmodule
