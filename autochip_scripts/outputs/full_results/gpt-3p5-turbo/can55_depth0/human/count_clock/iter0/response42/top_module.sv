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
			hh <= 8'b0001; // 12 in BCD
			mm <= 8'b0000;
			ss <= 8'b0000;
			pm <= 1'b0; // AM
		end else if (ena) begin
			ss <= ss + 1'b1;
			if (ss > 8'b01011001) begin // 59 in BCD
				ss <= 8'b0000;
				mm <= mm + 1'b1;
				if (mm > 8'b01011001) begin // 59 in BCD
					mm <= 8'b0000;
					hh <= hh + 1'b1;
					if (hh > 8'b00011001) begin // 12 in BCD
						hh <= 8'b0001; // 12 in BCD
						pm <= ~pm; // Toggle AM/PM
					end
				end
			end
		end
	end
	
endmodule
