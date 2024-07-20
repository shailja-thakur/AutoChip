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
			if (ss + 1'b1 >= 2'b011010) begin // BCD encoding for 59, reset seconds and increment minutes
				ss <= 2'b000000;
				mm <= mm + 1'b1;
				
				if (mm + 1'b1 >= 2'b011110) begin // BCD encoding for 59, reset minutes and increment hours
					mm <= 2'b000000;
					hh <= hh + 1'b1;
					
					if (hh >= 2'b00011010) begin // BCD encoding for 12, reset hours and toggle AM/PM
						hh <= 2'b00010010;
						pm <= ~pm; // Toggle between AM and PM
					end
				end
			end else begin
				ss <= ss + 1'b1;
			end
		end
	end

endmodule
