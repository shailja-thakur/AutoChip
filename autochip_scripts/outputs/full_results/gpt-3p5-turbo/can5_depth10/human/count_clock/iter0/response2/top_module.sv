module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			pm <= 1'b0;
			hh <= 8'b0000_1100;  // Set initial value to 12
			mm <= 8'b0000_0000;  // Set initial value to 00
			ss <= 8'b0000_0000;  // Set initial value to 00
		end else if (ena) begin
			ss <= ss + 1'b1;  // Increment seconds

			if (ss == 8'b0110_0000) begin
				ss <= 8'b0000_0000;  // Reset seconds to 00
				mm <= mm + 1'b1;  // Increment minutes

				if (mm == 8'b0110_0000) begin
					mm <= 8'b0000_0000;  // Reset minutes to 00
					hh <= hh + 1'b1;  // Increment hours

					// Check for rollover from 12 to 1 (AM to PM)
					if (hh == 8'b0001_0011) begin
						if (pm) begin
							hh <= 8'b0000_0001;  // Rollover to 1
							pm <= 1'b0;  // Set to AM
						end else begin
							hh <= 8'b0000_0001;  // Rollover to 1
							pm <= 1'b1;  // Set to PM
						end
					end else if (hh == 8'b0000_0000) begin
						// Rollover from 12 to 12 (PM to AM)
						if (pm) begin
							hh <= 8'b0000_1100;  // Rollover to 12
							pm <= 1'b0;  // Set to AM
						end else begin
							hh <= 8'b0000_1100;  // Rollover to 12
							pm <= 1'b1;  // Set to PM
						end
					end
				end
			end
		end
	end

endmodule
