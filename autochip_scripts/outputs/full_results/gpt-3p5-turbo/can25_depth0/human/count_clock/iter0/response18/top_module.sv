module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);
	
	always @(posedge clk) begin
		if (reset) begin
			// Reset the clock to "12:00 AM"
			pm <= 0;
			hh <= 8'b0001; // 12 in BCD
			mm <= 8'b0000;
			ss <= 8'b0000;
		end else if (ena) begin
			// Increment the clock by 1 second
			ss <= ss + 1;
			
			if (ss >= 60) begin
				ss <= 8'b0000;
				mm <= mm + 1;
				
				if (mm >= 60) begin
					mm <= 8'b0000;
					
					hh <= hh + 1;
					
					if (hh[3] & hh[2] & hh[1] & hh[0]) begin
						// Reset to "01:00 AM" if the clock reaches "13:00"
						hh <= 8'b0001;
						pm <= 0;
					end else if (hh >= 12) begin
						// Change to PM if the clock reaches "12:00"
						pm <= 1;
					end
				end
			end
		end
	end
endmodule
