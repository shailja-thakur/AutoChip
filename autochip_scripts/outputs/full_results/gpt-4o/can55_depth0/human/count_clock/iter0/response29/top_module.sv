module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Initialize the output values
	initial begin
		hh = 8'b00010010; // 12 in BCD
		mm = 8'b00000000; // 00 in BCD
		ss = 8'b00000000; // 00 in BCD
		pm = 1'b0; // AM
	end

	always @(posedge clk) begin
		if (reset) begin
			// Reset the clock to 12:00 AM
			hh <= 8'b00010010; // 12 in BCD
			mm <= 8'b00000000; // 00 in BCD
			ss <= 8'b00000000; // 00 in BCD
			pm <= 1'b0; // AM
		end
		else if (ena) begin
			// Increment the seconds
			if (ss == 8'b01011001) begin // 59 in BCD
				ss <= 8'b00000000;
				// Increment the minutes
				if (mm == 8'b01011001) begin // 59 in BCD
					mm <= 8'b00000000;
					// Increment the hours
					if (hh == 8'b00010010) begin // 12 in BCD
						hh <= 8'b00000001; // 1 in BCD
						pm <= ~pm; // Toggle am/pm bit
					end
					else if (hh == 8'b00001001) begin // 9 in BCD
						hh <= 8'b00010000; // 10 in BCD
					end
					else if (hh == 8'b00010000) begin // 10 in BCD
						hh <= 8'b00010001; // 11 in BCD
					end
					else if (hh == 8'b00010001) begin // 11 in BCD
						hh <= 8'b00010010; // 12 in BCD
					end
					else begin
						hh <= hh + 1;
					end
				end
				else begin
					// Handle BCD increment for minutes
					if ((mm[3:0] == 4'b1001)) begin
						mm[3:0] <= 4'b0000;
						mm[7:4] <= mm[7:4] + 1;
					end
					else begin
						mm[3:0] <= mm[3:0] + 1;
					end
				end
			end
			else begin
				// Handle BCD increment for seconds
				if ((ss[3:0] == 4'b1001)) begin
					ss[3:0] <= 4'b0000;
					ss[7:4] <= ss[7:4] + 1;
				end
				else begin
					ss[3:0] <= ss[3:0] + 1;
				end
			end
		end
	end
endmodule
