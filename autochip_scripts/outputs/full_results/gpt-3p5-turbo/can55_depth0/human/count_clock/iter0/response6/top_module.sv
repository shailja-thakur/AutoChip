module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Define internal signals
	reg [3:0] hh_temp;
	reg [3:0] mm_temp;
	reg [3:0] ss_temp;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset the clock to "12:00 AM"
			pm <= 0;
			hh_temp <= 4'b0001;
			mm_temp <= 4'b0000;
			ss_temp <= 4'b0000;
		end else if (ena) begin
			// Increment the clock once per second
			if (ss_temp == 4'b1001) begin
				ss_temp <= 4'b0000;
				if (mm_temp == 4'b1001) begin
					mm_temp <= 4'b0000;
					if (hh_temp == 4'b0001) begin
						if (pm) begin
							hh_temp <= 4'b0000;
							pm <= 0;
						end else begin
							hh_temp <= 4'b0001;
							pm <= 1;
						end
					end else if (hh_temp == 4'b0000) begin
						hh_temp <= 4'b0001;
					end else begin
						hh_temp <= hh_temp + 1;
					end
				end else begin
					mm_temp <= mm_temp + 1;
				end
			end else begin
				ss_temp <= ss_temp + 1;
			end
		end
	end

	// Convert BCD to binary and assign to outputs
	always @* begin
		hh = {4'b0000, hh_temp};
		mm = {4'b0000, mm_temp};
		ss = {4'b0000, ss_temp};
	end

endmodule
