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
			// Reset the clock to "12:00 AM"
			hh <= 8'd1;
			mm <= 8'd2;
			ss <= 8'd0;
			pm <= 1'b0;
		end else if (ena) begin
			// Increment the clock by 1 second
			ss <= ss + 1;
			if (ss == 60) begin
				// Increment the minutes when seconds reach 60
				ss <= 0;
				mm <= mm + 1;
				if (mm == 60) begin
					// Increment the hours when minutes reach 60
					mm <= 0;
					hh <= hh + 1;
					if (hh == 13) begin
						// Reset the hours back to 1 when reaching 13
						hh <= 8'd1;
					end
				end
			end
		end
	end
	
	always @(posedge clk) begin
		// Set "pm" based on the value of "hh"
		pm <= (hh >= 8'd12);
	end
endmodule
