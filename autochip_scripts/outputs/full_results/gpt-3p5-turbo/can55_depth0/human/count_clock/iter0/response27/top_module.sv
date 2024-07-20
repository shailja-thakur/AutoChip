module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Variables for counting
	reg [3:0] hours_tens;
	reg [3:0] hours_units;
	reg [3:0] minutes_tens;
	reg [3:0] minutes_units;
	reg [3:0] seconds_tens;
	reg [3:0] seconds_units;
	
	// Reset behavior
	always @(posedge clk) begin
		if (reset) begin
			pm <= 0;
			hh <= 8'b0001; // Initialize to 12
			mm <= 8'b0000;
			ss <= 8'b0000;
		end
		// Other conditions
		else if (ena) begin
			// Increment seconds
			if (seconds_units == 4'b1001) begin
				seconds_units <= 4'b0000;
				// Increment minutes
				if (minutes_units == 4'b1001) begin
					minutes_units <= 4'b0000;
					// Increment tens of minutes
					if (minutes_tens == 4'b0101) begin
						minutes_tens <= 4'b0000;
						// Increment hours
						if (hours_units == 4'b1001) begin
							hours_units <= 4'b0000;
							// Increment tens of hours
							if (hours_tens == 4'b0001) begin
								hours_tens <= 4'b0000;
								pm <= ~pm; // Toggle am/pm
							end
							else begin
								hours_tens <= hours_tens + 1;
							end
						end
						else begin
							hours_units <= hours_units + 1;
						end
					end
					else begin
						minutes_tens <= minutes_tens + 1;
					end
				end
				else begin
					minutes_units <= minutes_units + 1;
				end
			end
			else begin
				seconds_units <= seconds_units + 1;
			end
		end
	end
	
	// BCD to decimal conversion for output
	always @(hours_tens, hours_units, minutes_tens, minutes_units, seconds_tens, seconds_units) begin
		hh = {hours_tens, hours_units};
		mm = {minutes_tens, minutes_units};
		ss = {seconds_tens, seconds_units};
	end

endmodule
