module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal signals
	reg [3:0] hour_units;
	reg [3:0] hour_tens;
	reg [3:0] min_units;
	reg [3:0] min_tens;
	reg [3:0] sec_units;
	reg [3:0] sec_tens;

	// Sequential logic for counters
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hour_units <= 4'b0000;
			hour_tens <= 4'b0001;
			min_units <= 4'b0000;
			min_tens <= 4'b0000;
			sec_units <= 4'b0000;
			sec_tens <= 4'b0000;
		end else if (ena) begin
			if (sec_units == 4'b1001 && sec_tens == 4'b0101) begin
				// Increment minutes
				sec_units <= 4'b0000;
				sec_tens <= 4'b0000;

				if (min_units == 4'b1001 && min_tens == 4'b0101) begin
					// Increment hours
					min_units <= 4'b0000;
					min_tens <= 4'b0000;

					if (hour_units == 4'b0001 && hour_tens == 4'b0010) begin
						// Toggle AM/PM
						hour_units <= 4'b0000;
						hour_tens <= 4'b0000;
						pm <= ~pm;
					end else if (hour_units == 4'b0000 && hour_tens == 4'b0010) begin
						// Reset to 12 AM
						hour_units <= 4'b0000;
						hour_tens <= 4'b0001;
						pm <= 0;
					end else if (hour_units == 4'b0001 && hour_tens == 4'b0001) begin
						// Increment hour tens (1 to 2)
						hour_units <= 4'b0000;
						hour_tens <= hour_tens + 1;
					end else begin
						// Increment hour units (0 to 1)
						hour_units <= hour_units + 1;
					end
				end else if (min_units == 4'b0000 && min_tens == 4'b0101) begin
					// Increment minute tens (0 to 1)
					min_units <= 4'b0000;
					min_tens <= 4'b0000;
				end else begin
					// Increment minute units
					min_units <= min_units + 1;
				end
			end else if (sec_units == 4'b1001 && sec_tens == 4'b0000) begin
				// Increment second tens (0 to 1)
				sec_units <= 4'b0000;
				sec_tens <= 4'b0000;
			end else begin
				// Increment second units
				sec_units <= sec_units + 1;
			end
		end
	end

	// Assign outputs
	assign hh = {hour_tens, hour_units};
	assign mm = {min_tens, min_units};
	assign ss = {sec_tens, sec_units};

endmodule
