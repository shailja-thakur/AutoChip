module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Unpack BCD digits
    wire [3:0] ss_ones, ss_tens;
    wire [3:0] mm_ones, mm_tens;
    wire [3:0] hh_ones, hh_tens;
	
	assign ss_ones = ss[3:0];
	assign ss_tens = ss[7:4];
	assign mm_ones = mm[3:0];
	assign mm_tens = mm[7:4];
	assign hh_ones = hh[3:0];
	assign hh_tens = hh[7:4];

	always @(posedge clk) begin
		if (reset) begin
			// Reset the clock to 12:00 AM
			hh <= 8'b0001_0010; // BCD for 12
			mm <= 8'b0000_0000; // BCD for 00
			ss <= 8'b0000_0000; // BCD for 00
			pm <= 1'b0;         // AM
		end else if (ena) begin
			// Increment seconds
			if (ss_ones == 9) begin
				ss[3:0] <= 0;
				if (ss_tens == 5) begin
					ss[7:4] <= 0;
					// Increment minutes
					if (mm_ones == 9) begin
						mm[3:0] <= 0;
						if (mm_tens == 5) begin
							mm[7:4] <= 0;
							// Increment hours
							if (hh == 8'b0010_0011) begin // Check for 12
								hh <= 8'b0001_0010; // BCD for 1
								pm <= ~pm; // Toggle AM/PM
							end else if (hh_ones == 9) begin
								hh[3:0] <= 0;
								hh[7:4] <= hh_tens + 1;
							end else if (hh == 8'b0001_0010) begin // If it's 12, wrap to 1
								hh <= 8'b0001_0000;
							end else begin
								hh[3:0] <= hh_ones + 1;
							end
						end else begin
							mm[7:4] <= mm_tens + 1;
						end
					end else begin
						mm[3:0] <= mm_ones + 1;
					end
				end else begin
					ss[7:4] <= ss_tens + 1;
				end
			end else begin
				ss[3:0] <= ss_ones + 1;
			end
		end
	end
endmodule
