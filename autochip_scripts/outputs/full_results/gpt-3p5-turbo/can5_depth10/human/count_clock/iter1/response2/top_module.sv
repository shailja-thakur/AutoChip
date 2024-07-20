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
			hh <= 8'b00010010; // 12
			mm <= 8'b00000000; // 00
			ss <= 8'b00000000; // 00
			pm <= 1'b0; // AM
		end else if (ena) begin
			ss <= ss + 1;
			if (ss == 8'b01011000) begin // 59
				ss <= 8'b00000000; // reset seconds
				mm <= mm + 1;
				if (mm == 8'b01011000) begin // 59
					mm <= 8'b00000000; // reset minutes
					hh <= hh + 1;
					if (hh == 8'b00010110) begin // 12
						hh <= 8'b00010010; // reset hours
						pm <= ~pm; // toggle AM/PM indicator
					end
				end
			end
		end
	end

endmodule
