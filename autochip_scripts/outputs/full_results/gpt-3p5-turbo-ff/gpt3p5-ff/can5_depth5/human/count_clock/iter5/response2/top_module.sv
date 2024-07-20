module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	always @(posedge clk) begin
		if (reset) begin
			pm <= 1'b0;
			hh <= 8'b00010010; // Initialize hours to 12 AM
			mm <= 8'b00000000; // Initialize minutes to 00
			ss <= 8'b00000000; // Initialize seconds to 00
		end else if (ena) begin
			if (ss == 8'b01101000) begin
				// Seconds overflow
				ss <= 8'b00000000; // Reset seconds
				mm <= mm + 1'b1; // Increment minutes
				if (mm == 8'b01110000) begin
					// Minutes overflow
					mm <= 8'b00000000; // Reset minutes
					hh <= hh + 1'b1; // Increment hours
					if (hh == 8'b00011010) begin
						// Hours overflow
						pm <= ~pm; // Toggle AM/PM indicator
						hh <= 8'b00010000; // Reset hours
					end
				end
			end else begin
				ss <= ss + 1'b1; // Increment seconds
			end
		end
	end

endmodule
