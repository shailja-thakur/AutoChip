module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal signals
	reg [3:0] hours_tens;  // BCD representation of tens place of hours
	reg [3:0] hours_ones;  // BCD representation of ones place of hours
	reg [3:0] minutes_tens;  // BCD representation of tens place of minutes
	reg [3:0] minutes_ones;  // BCD representation of ones place of minutes
	reg [3:0] seconds_tens;  // BCD representation of tens place of seconds
	reg [3:0] seconds_ones;  // BCD representation of ones place of seconds
	
	reg [3:0] hours_tens_next;  // Next value of tens place of hours
	reg [3:0] hours_ones_next;  // Next value of ones place of hours
	reg [3:0] minutes_tens_next;  // Next value of tens place of minutes
	reg [3:0] minutes_ones_next;  // Next value of ones place of minutes
	reg [3:0] seconds_tens_next;  // Next value of tens place of seconds
	reg [3:0] seconds_ones_next;  // Next value of ones place of seconds
	
	// Clock divider variables
	reg [15:0] counter;  // 16-bit counter for generating pulses
	
	// Output registers
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			pm <= 0;
			hh <= 8'b0001_0010;  // Initialize hours to 12
			mm <= 8'b0000_0000;  // Initialize minutes to 0
			ss <= 8'b0000_0000;  // Initialize seconds to 0
			
			hours_tens <= 4'b0001;  // Initialize hours tens place to 1
			hours_ones <= 4'b0010;  // Initialize hours ones place to 2
			minutes_tens <= 4'b0000;  // Initialize minutes tens place to 0
			minutes_ones <= 4'b0000;  // Initialize minutes ones place to 0
			seconds_tens <= 4'b0000;  // Initialize seconds tens place to 0
			seconds_ones <= 4'b0000;  // Initialize seconds ones place to 0
		end else begin
			if (ena && (counter == 16'hFFFF)) begin
				// Increment seconds
				if (seconds_ones == 4'b1001) begin
					if (seconds_tens == 4'b0101) begin
						// Increment minutes
						if (minutes_ones == 4'b1001) begin
							if (minutes_tens == 4'b0101) begin
								// Increment hours
								if (hours_ones == 4'b1001) begin
									if (hours_tens == 4'b0001) begin
										// Reset to 12:00 AM
										pm <= 0;
										hh <= 8'b0001_0010;
										minutes_tens_next <= 4'b0000;
										minutes_ones_next <= 4'b0000;
										seconds_tens_next <= 4'b0000;
										seconds_ones_next <= 4'b0000;
									end else begin
										// Increment tens place of hours
										pm <= pm;
										hours_tens_next <= hours_tens + 1;
										hours_ones_next <= 4'b0000;
										minutes_tens_next <= minutes_tens;
										minutes_ones_next <= minutes_ones;
										seconds_tens_next <= seconds_tens;
										seconds_ones_next <= seconds_ones;
									end
								end else begin
									// Increment ones place of hours
									pm <= pm;
									hours_tens_next <= hours_tens;
									hours_ones_next <= hours_ones + 1;
									minutes_tens_next <= minutes_tens;
									minutes_ones_next <= minutes_ones;
									seconds_tens_next <= seconds_tens;
									seconds_ones_next <= seconds_ones;
								end
							end else begin
								// Increment tens place of minutes
								pm <= pm;
								hours_tens_next <= hours_tens;
								hours_ones_next <= hours_ones;
								minutes_tens_next <= minutes_tens + 1;
								minutes_ones_next <= 4'b0000;
								seconds_tens_next <= seconds_tens;
								seconds_ones_next <= seconds_ones;
							end
						end else begin
							// Increment ones place of minutes
							pm <= pm;
							hours_tens_next <= hours_tens;
							hours_ones_next <= hours_ones;
							minutes_tens_next <= minutes_tens;
							minutes_ones_next <= minutes_ones + 1;
							seconds_tens_next <= seconds_tens;
							seconds_ones_next <= seconds_ones;
						end
					end else begin
						// Increment tens place of seconds
						pm <= pm;
						hours_tens_next <= hours_tens;
						hours_ones_next <= hours_ones;
						minutes_tens_next <= minutes_tens;
						minutes_ones_next <= minutes_ones;
						seconds_tens_next <= seconds_tens + 1;
						seconds_ones_next <= 4'b0000;
					end
				end else begin
					// Increment ones place of seconds
					pm <= pm;
					hours_tens_next <= hours_tens;
					hours_ones_next <= hours_ones;
					minutes_tens_next <= minutes_tens;
					minutes_ones_next <= minutes_ones;
					seconds_tens_next <= seconds_tens;
					seconds_ones_next <= seconds_ones + 1;
				end
			end else begin
				// Hold current time
				pm <= pm;
				hours_tens_next <= hours_tens;
				hours_ones_next <= hours_ones;
				minutes_tens_next <= minutes_tens;
				minutes_ones_next <= minutes_ones;
				seconds_tens_next <= seconds_tens;
				seconds_ones_next <= seconds_ones;
			end
		end
	end
	
	// Next value assignments
	always @(posedge clk) begin
		hours_tens <= hours_tens_next;
		hours_ones <= hours_ones_next;
		minutes_tens <= minutes_tens_next;
		minutes_ones <= minutes_ones_next;
		seconds_tens <= seconds_tens_next;
		seconds_ones <= seconds_ones_next;
	end
	
	// Output assignments
	assign hh = {hours_tens[3:0], hours_ones[3:0]};
	assign mm = {minutes_tens[3:0], minutes_ones[3:0]};
	assign ss = {seconds_tens[3:0], seconds_ones[3:0]};
	
endmodule
