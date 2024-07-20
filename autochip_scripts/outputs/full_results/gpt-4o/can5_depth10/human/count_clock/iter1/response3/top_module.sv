module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Helper function to increment a BCD digit
	function [7:0] increment_bcd(input [7:0] bcd);
		if (bcd[3:0] == 4'd9) begin
			if (bcd[7:4] == 4'd9)
				increment_bcd = 8'h00;
			else
				increment_bcd = {bcd[7:4] + 1, 4'd0};
		end else
			increment_bcd = bcd + 1;
	endfunction

	always @(posedge clk) begin
		if (reset) begin
			// Reset all the counters
			hh <= 8'h12; // 12 in BCD
			mm <= 8'h00; // 00 in BCD
			ss <= 8'h00; // 00 in BCD
			pm <= 1'b0; // AM (pm = 0)
		end
		else if (ena) begin
			// Increment seconds
			ss <= increment_bcd(ss);
			if (ss == 8'h59) begin
				ss <= 8'h00;
				// Increment minutes
				mm <= increment_bcd(mm);
				if (mm == 8'h59) begin
					mm <= 8'h00;
					// Increment hours
					if (hh == 8'h12) begin
						hh <= 8'h01;
						pm <= ~pm; // Toggle AM/PM
					end
					else if (hh == 8'h09) begin
						hh <= 8'h10; // Handle transition from 9 to 10
					end
					else
						hh <= increment_bcd(hh);
				end
			end
		end
	end
endmodule
