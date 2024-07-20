module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

// always block triggered on the rising edge of the clock signal
	always @(posedge clk) begin
		if (reset) begin
			q <= 0; // reset the counter to 0
		end else begin
			if (slowena) begin
				if (q == 9) begin
					q <= 0; // reset the counter to 0 if it is equal to 9
				end else begin
					q <= q + 1; // increment the counter by 1
				end
			end
		end
	end
endmodule
