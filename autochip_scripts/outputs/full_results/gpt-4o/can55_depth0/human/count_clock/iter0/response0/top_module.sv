module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Binary-coded decimal incrementer
	function [7:0] bcd_increment(input [7:0] bcd);
		begin
			if (bcd[3:0] == 4'd9) begin
				bcd_increment[3:0] = 4'd0;
				bcd_increment[7:4] = bcd[7:4] + 1'b1;
			end else begin
				bcd_increment[3:0] = bcd[3:0] + 1'd1;
				bcd_increment[7:4] = bcd[7:4];
			end
			if (bcd_increment[7:4] == 4'd10)
				bcd_increment[7:4] = 4'd0;
		end
	endfunction
	
	// Resets to 12:00:00 AM
	always @(posedge clk) begin
		if (reset) begin
			hh <= 8'b00010010; // 12 in BCD
			mm <= 8'b00000000; // 00 in BCD
			ss <= 8'b00000000; // 00 in BCD
			pm <= 1'b0;
		end else if (ena) begin
			// Increment seconds
			ss <= bcd_increment(ss);
			if (ss == 8'b01011001) begin
				ss <= 8'b00000000;
				// Increment minutes
				mm <= bcd_increment(mm);
				if (mm == 8'b01011001) begin
					mm <= 8'b00000000;
					// Increment hours
					if (hh == 8'b00010010) begin // 12 in BCD
						hh <= 8'b00000001; // 1 in BCD
						pm <= ~pm; // Toggle AM/PM
					end else if (hh == 8'b00010001) begin // 11 in BCD
						hh <= 8'b00010010; // Roll over to 12 in BCD
					end else begin
						hh <= bcd_increment(hh);
					end
				end
			end
		end
	end
endmodule
