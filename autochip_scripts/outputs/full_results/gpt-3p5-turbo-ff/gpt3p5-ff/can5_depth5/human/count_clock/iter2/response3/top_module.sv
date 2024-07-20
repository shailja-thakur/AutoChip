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
			pm <= 1'b0;
			hh <= 8'b00000001; // Initialize hours to 12 AM
			mm <= 8'b00000000; // Initialize minutes to 00
			ss <= 8'b00000000; // Initialize seconds to 00
		end else if (ena) begin
			ss <= ss + 1'b1; // Increment seconds
			if (ss == 8'b10011000) begin
				// Seconds overflow
				ss <= 8'b00000000; // Reset seconds
				mm <= mm + 1'b1; // Increment minutes
				if (mm == 8'b10011010) begin
					// Minutes overflow
					mm <= 8'b00000000; // Reset minutes
					hh <= hh + 1'b1; // Increment hours
					if (hh == 8'b00010010) begin
						// Hours overflow
						pm <= ~pm; // Toggle AM/PM indicator
						hh <= 8'b00000001; // Reset hours
					end
				end
			end
		end
	end

endmodule
