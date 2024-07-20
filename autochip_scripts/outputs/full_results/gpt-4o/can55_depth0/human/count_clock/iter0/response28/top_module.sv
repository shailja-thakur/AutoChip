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
			hh <= 8'b00010010; // BCD for "12"
			mm <= 8'b00000000; // BCD for "00"
			ss <= 8'b00000000; // BCD for "00"
			pm <= 1'b0; // AM
		end else if (ena) begin
			// Increment seconds
			if (ss[3:0] == 4'd9) begin
				ss[3:0] <= 4'd0;
				if (ss[7:4] == 4'd5) begin
					ss[7:4] <= 4'd0;
					// Increment minutes
					if (mm[3:0] == 4'd9) begin
						mm[3:0] <= 4'd0;
						if (mm[7:4] == 4'd5) begin
							mm[7:4] <= 4'd0;
							// Increment hours
							if (hh == 8'b00010010) begin // If hours is "12"
								hh <= 8'b00000001; // Set hours to "01"
								pm <= ~pm; // Toggle AM/PM
							end else if (hh[3:0] == 4'd9) begin // If LSB BCD digit is 9
								hh[3:0] <= 4'd0;
								hh[7:4] <= hh[7:4] + 1;
							end else begin
								hh[3:0] <= hh[3:0] + 1;
							end
						end else begin
							mm[7:4] <= mm[7:4] + 1;
						end
					end else begin
						mm[3:0] <= mm[3:0] + 1;
					end
				end else begin
					ss[7:4] <= ss[7:4] + 1;
				end
			end else begin
				ss[3:0] <= ss[3:0] + 1;
			end
		end
	end
endmodule
