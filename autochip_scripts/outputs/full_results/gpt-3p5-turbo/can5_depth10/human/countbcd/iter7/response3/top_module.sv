module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	reg [3:0] counter [3:0];

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena <= 3'b0;
			counter[3:0] <= 4'b0000;
		end else begin
			if (counter[3:0] == 4'b1001) begin
				counter[3:0] <= 4'b0000;
				if (counter[7:4] == 4'b1001) begin
					counter[7:4] <= 4'b0000;
					if (counter[11:8] == 4'b1001) begin
						counter[11:8] <= 4'b0000;
						if (counter[15:12] == 4'b1001)
							counter[15:12] <= 4'b0000;
						else
							counter[15:12] <= counter[15:12] + 1;
					end else
						counter[11:8] <= counter[11:8] + 1;
				end else
					counter[7:4] <= counter[7:4] + 1;
			end else
				counter[3:0] <= counter[3:0] + 1;
			
			ena <= counter[11:9];
			q <= counter[15:0];
		end
	end
endmodule
