module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Counter for seconds
	reg [7:0] sec_cnt;

	// Counter for minutes
	reg [7:0] min_cnt;

	// Counter for hours
	reg [7:0] hour_cnt;

	always @(posedge clk) begin
		// Check if reset is high
		if (reset) begin
			// Reset the counters
			sec_cnt <= 0;
			min_cnt <= 0;
			hour_cnt <= 0;

			// Set the initial values for hh, mm, and ss
			hh <= 8'b00000001; // 12 in BCD
			mm <= 8'b00000000; // 00 in BCD
			ss <= 8'b00000000; // 00 in BCD

			// Set AM as the initial state
			pm <= 0;
		end else if (ena) begin
			// Increment the seconds counter
			sec_cnt <= sec_cnt + 1;

			// Check if a minute has passed
			if (sec_cnt == 10) begin
				sec_cnt <= 0;

				// Increment the minutes counter
				min_cnt <= min_cnt + 1;

				// Check if an hour has passed
				if (min_cnt == 10) begin
					min_cnt <= 0;

					// Increment the hours counter
					hour_cnt <= hour_cnt + 1;

					// Check if it's PM
					if (hour_cnt == 10) begin
						hour_cnt <= 0;

						// Toggle the pm signal
						pm <= ~pm;
					end else if (hour_cnt == 2'b11) begin
						hour_cnt <= 8'b00000000; // Reset hours counter to 12 (AM)
						pm <= 0;
					end
				end
			end
		end
	end

	// Assign the BCD values for hh, mm, and ss
	assign hh = {4'b0000, hour_cnt};
	assign mm = {4'b0000, min_cnt};
	assign ss = {4'b0000, sec_cnt};
endmodule
