module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all outputs to 0
			q <= 16'd0;
			ena <= 3'b0;
		end else begin
			// Increment the ones digit every clock cycle
			if (q[3:0] != 4'b9)
				q[3:0] <= q[3:0] + 1;
			else begin
				// Carry over to the tens digit
				q[3:0] <= 4'b0;
				
				// Enable incrementing of the tens digit
				ena[1] <= 1'b1;
				
				// Increment the tens digit every clock cycle when enabled
				if (ena[1]) begin
					if (q[7:4] != 4'b9)
						q[7:4] <= q[7:4] + 1;
					else begin
						// Carry over to the hundreds digit
						q[7:4] <= 4'b0;
						
						// Enable incrementing of the hundreds digit
						ena[2] <= 1'b1;
						
						// Increment the hundreds digit every clock cycle when enabled
						if (ena[2]) begin
							if (q[11:8] != 4'b9)
								q[11:8] <= q[11:8] + 1;
							else begin
								// Carry over to the thousands digit
								q[11:8] <= 4'b0;
								
								// Enable incrementing of the thousands digit
								ena[3] <= 1'b1;
								
								// Increment the thousands digit every clock cycle when enabled
								if (ena[3]) begin
									if (q[15:12] != 4'b9)
										q[15:12] <= q[15:12] + 1;
									else
										// Reset all digits to 0 when the thousands digit reaches 9
										q <= 16'd0;
								end
							end
						end
					end
				end
			end
		end
	end

endmodule
