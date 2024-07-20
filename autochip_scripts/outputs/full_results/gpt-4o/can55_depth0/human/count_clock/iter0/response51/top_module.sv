module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal registers for BCD counters
	reg [3:0] seconds_ones;
	reg [3:0] seconds_tens;
	reg [3:0] minutes_ones;
	reg [3:0] minutes_tens;
	reg [3:0] hours_ones;
	reg [3:0] hours_tens;
	reg is_pm;
	
	always @(posedge clk) begin
		if (reset) begin
			// Reset to "12:00 AM"
			seconds_ones <= 0;
			seconds_tens <= 0;
			minutes_ones <= 0;
			minutes_tens <= 0;
			hours_ones <= 2; // 12 in BCD -> "12"
			hours_tens <= 1;
			pm <= 0; // AM
		end 
		else if (ena) begin
			// Increment seconds
			if (seconds_ones == 9) begin
				seconds_ones <= 0;
				if (seconds_tens == 5) begin
					seconds_tens <= 0;
					// Increment minutes
					if (minutes_ones == 9) begin
						minutes_ones <= 0;
						if (minutes_tens == 5) begin
							minutes_tens <= 0;
							// Increment hours
							if ((hours_tens == 1 && hours_ones == 2) || (hours_tens == 0 && hours_ones == 9)) begin
								hours_ones <= 1;
								hours_tens <= 0;
								pm <= ~pm; // Toggle AM/PM
							end else if (hours_ones == 9) begin
								hours_ones <= 0;
								hours_tens <= hours_tens + 1;
							end else begin
								hours_ones <= hours_ones + 1;
							end
						end else begin
							minutes_tens <= minutes_tens + 1;
						end
					end else begin
						minutes_ones <= minutes_ones + 1;
					end
				end else begin
					seconds_tens <= seconds_tens + 1;
				end
			end else begin
				seconds_ones <= seconds_ones + 1;
			end
		end
		
		// Combine BCD digits into output
		ss <= {seconds_tens, seconds_ones};
		mm <= {minutes_tens, minutes_ones};
		hh <= {hours_tens, hours_ones};
	end
endmodule
