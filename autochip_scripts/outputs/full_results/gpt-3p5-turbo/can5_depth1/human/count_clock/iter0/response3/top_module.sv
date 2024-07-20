module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Create internal registers
	reg [3:0] hh_tens;
	reg [3:0] hh_ones;
	reg [3:0] mm_tens;
	reg [3:0] mm_ones;
	reg [3:0] ss_tens;
	reg [3:0] ss_ones;

	// Create counter for AM/PM toggle
	reg [0:0] am_pm_counter;
	always @(posedge clk) begin
		if (reset) begin
			am_pm_counter <= 1'b0;
		end else if (ena) begin
			if (am_pm_counter == 1'b0) begin
				am_pm_counter <= 1'b1;
			end else begin
				am_pm_counter <= 1'b0;
			end
		end
	end

	// Create counter for seconds
	reg [5:0] seconds_counter;
	always @(posedge clk) begin
		if (reset) begin
			seconds_counter <= 6'b000000;
		end else if (ena) begin
			if (seconds_counter == 6'b010110) begin // 59 in binary
				seconds_counter <= 6'b000000;
				if (mm_ones == 4'b1001) begin // 9 in BCD
					mm_ones <= 4'b0000;
					if (mm_tens == 4'b0000) begin
						mm_tens <= 4'b0001;
					end else if (mm_tens == 4'b0001) begin
						mm_tens <= 4'b0000;
						if (hh_ones == 4'b1001) begin // 9 in BCD
							hh_ones <= 4'b0000;
							if (hh_tens == 4'b0001) begin
								hh_tens <= 4'b0000;
							end else if (hh_tens == 4'b0000) begin
								hh_tens <= 4'b0001;
							end
						end else begin
							hh_ones <= hh_ones + 1;
						end
					end
				end else begin
					mm_ones <= mm_ones + 1;
				end
			end else begin
				seconds_counter <= seconds_counter + 1;
			end
		end
	end

	// Assign output values
	always @* begin
		if (reset) begin
			pm = 1'b0;
			hh = 8'b00000000;
			mm = 8'b00000000;
			ss = 8'b00000000;
		end else if (am_pm_counter == 1'b0) begin
			pm = 1'b0; // AM
		end else begin
			pm = 1'b1; // PM
		end
		hh = {hh_tens, hh_ones};
		mm = {mm_tens, mm_ones};
		ss = {ss_tens, ss_ones};
	end

endmodule
