module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Define internal signals
	reg [3:0] hour_tens;
	reg [3:0] hour_ones;
	reg [3:0] min_tens;
	reg [3:0] min_ones;
	reg [3:0] sec_tens;
	reg [3:0] sec_ones;

	// Clock logic
	always @(posedge clk) begin
		if (reset) begin
			hour_tens <= 4'b0000; // Reset hour tens to 0
			hour_ones <= 4'b0000; // Reset hour ones to 0
			min_tens <= 4'b0000; // Reset minute tens to 0
			min_ones <= 4'b0000; // Reset minute ones to 0
			sec_tens <= 4'b0000; // Reset second tens to 0
			sec_ones <= 4'b0000; // Reset second ones to 0
			pm <= 1'b0; // Reset PM indicator to AM
		end else if (ena) begin
			// Increment seconds
			if (sec_ones == 4'b1001 && sec_tens == 4'b0101) begin
				sec_ones <= 4'b0000; // Reset ones place of seconds to 0
				sec_tens <= 4'b0000; // Reset tens place of seconds to 0
				// Increment minutes
				if (min_ones == 4'b1001 && min_tens == 4'b0101) begin
					min_ones <= 4'b0000; // Reset ones place of minutes to 0
					min_tens <= 4'b0000; // Reset tens place of minutes to 0
					// Increment hours
					if (hour_ones == 4'b0001 && hour_tens == 4'b0000) begin
						hour_ones <= 4'b0000; // Reset ones place of hours to 0
						hour_tens <= 4'b0000; // Reset tens place of hours to 0
						pm <= !pm; // Toggle AM/PM indicator
					end else if (hour_ones == 4'b1001 && hour_tens == 4'b0001) begin
						hour_ones <= 4'b0000; // Reset ones place of hours to 0
						hour_tens <= 4'b0000; // Reset tens place of hours to 0
					end else if (hour_ones == 4'b1001 && hour_tens == 4'b0000) begin
						hour_ones <= 4'b0000; // Reset ones place of hours to 0
						hour_tens <= 4'b0001; // Increment tens place of hours
					end else begin
						hour_ones <= hour_ones + 4'b0001; // Increment ones place of hours
					end
				end else if (min_ones == 4'b1001 && min_tens == 4'b0100) begin
					min_ones <= 4'b0000; // Reset ones place of minutes to 0
					min_tens <= 4'b0000; // Reset tens place of minutes to 0
				end else if (min_ones == 4'b1001 && min_tens == 4'b0011) begin
					min_ones <= 4'b0000; // Reset ones place of minutes to 0
					min_tens <= 4'b0100; // Increment tens place of minutes
				end else begin
					min_ones <= min_ones + 4'b0001; // Increment ones place of minutes
				end
			end else if (sec_ones == 4'b1001 && sec_tens == 4'b0100) begin
				sec_ones <= 4'b0000; // Reset ones place of seconds to 0
				sec_tens <= 4'b0000; // Reset tens place of seconds to 0
			end else if (sec_ones == 4'b1001 && sec_tens == 4'b0011) begin
				sec_ones <= 4'b0000; // Reset ones place of seconds to 0
				sec_tens <= 4'b0100; // Increment tens place of seconds
			end else begin
				sec_ones <= sec_ones + 4'b0001; // Increment ones place of seconds
			end
		end
	end

	// Assign output signals
	assign hh = {hour_tens, hour_ones};
	assign mm = {min_tens, min_ones};
	assign ss = {sec_tens, sec_ones};

endmodule
