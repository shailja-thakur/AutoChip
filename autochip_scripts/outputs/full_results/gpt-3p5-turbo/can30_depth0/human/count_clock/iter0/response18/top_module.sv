module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// internal counters
	reg [7:0] hours;
	reg [7:0] minutes;
	reg [7:0] seconds;

	// AM/PM logic
	always @(posedge clk) begin
		if (reset) begin
			hours <= 8'b00000001; // set hours to 12:00 AM
			minutes <= 8'b00000000;
			seconds <= 8'b00000000;
			pm <= 1'b0; // clear PM flag
		end else if (ena) begin
			seconds <= seconds + 1;
			if (seconds == 60) begin
				seconds <= 8'b00000000;
				minutes <= minutes + 1;
				if (minutes == 60) begin
					minutes <= 8'b00000000;
					hours <= hours + 1;
					if (hours == 8'b00001100) begin
						hours <= 8'b00000001; // roll back to 12:00 AM
						pm <= ~pm; // toggle PM flag
					end else if (hours == 8'b00001101) begin
						hours <= 8'b00000001; // set hours to 01:00 AM (12-hour format)
						pm <= ~pm; // toggle PM flag
					end
				end
			end
		end
	end

	// BCD conversion logic
	always @(posedge clk) begin
		hh[3:0] <= hours[3:0];
		hh[7:4] <= hours[7:4];
		mm[3:0] <= minutes[3:0];
		mm[7:4] <= minutes[7:4];
		ss[3:0] <= seconds[3:0];
		ss[7:4] <= seconds[7:4];
	end

endmodule
