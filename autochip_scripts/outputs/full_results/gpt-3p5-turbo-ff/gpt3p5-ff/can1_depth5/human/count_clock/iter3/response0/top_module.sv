module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss
);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hh <= 8'b00010010; // Set initial value to 12:00 AM
			mm <= 8'b00000000;
			ss <= 8'b00000000;
			pm <= 1'b0; // Reset to AM
		end else if (ena) begin
			ss <= ss + 1'b1;
			
			if (ss >= 2'b1011) begin // BCD encoding for 9, reset seconds and increment minutes
				ss <= 2'b0000;
				mm <= mm + 1'b1;
				
				if (mm >= 2'b1111) begin // BCD encoding for 9, reset minutes and increment hours
					mm <= 2'b0000;
					hh <= hh + 1'b1;
					
					if (hh >= 2'b1011) begin // BCD encoding for 11, reset hours and toggle AM/PM
						hh <= 2'b0001;
						pm <= ~pm; // Toggle between AM and PM
					end
				end
			end
		end
	end
	
endmodule
