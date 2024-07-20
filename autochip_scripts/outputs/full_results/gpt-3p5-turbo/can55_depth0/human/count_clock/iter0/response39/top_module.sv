module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			pm <= 1'b0; // Reset to AM
			hh <= 8'b0000_1100; // Reset to 12
			mm <= 8'b0000_0000; // Reset to 00
			ss <= 8'b0000_0000; // Reset to 00
		end else if (ena) begin
			ss <= ss + 1; // Increment seconds
			if (ss == 8'b0110_0000) begin
				ss <= 8'b0000_0000; // Reset seconds to 00
				mm <= mm + 1; // Increment minutes
				if (mm == 8'b0110_0000) begin
					mm <= 8'b0000_0000; // Reset minutes to 00
					hh <= hh + 1; // Increment hours
					if (hh == 8'b0001_0010) begin
						hh <= 8'b0000_0001; // Reset hours to 01
						pm <= ~pm; // Toggle AM/PM indicator
					end else if (hh == 8'b0000_1101) begin
						hh <= 8'b0000_0000; // Reset hours to 12
						pm <= ~pm; // Toggle AM/PM indicator
					end
				end
			end
		end
	end

endmodule
