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
			if (ss == 8'b01011000) begin // Check for seconds overflow
				ss <= 8'b00000000; // Reset seconds
				mm <= mm + 8'b00000001; // Increment minutes
				
				if (mm == 8'b01101001) begin // Check for minutes overflow
					mm <= 8'b00000000; // Reset minutes
					hh <= hh + 8'b00000001; // Increment hours

					if (hh == 8'b00011010) begin // Check for hours overflow
						hh <= 8'b00000001; // Reset hours
						pm <= ~pm; // Toggle AM/PM indicator
					end
				end
			end else begin
				ss <= ss + 8'b00000001; // Increment seconds
			end
		end
	end

endmodule
