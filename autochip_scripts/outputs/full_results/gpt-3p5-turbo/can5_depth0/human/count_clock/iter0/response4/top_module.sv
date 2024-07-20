module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);
	
	always @(posedge reset or posedge clk)
	begin
		if (reset)
		begin
			hh <= 8'b00010010; // 12 in BCD
			mm <= 8'b00000000; // 00 in BCD
			ss <= 8'b00000000; // 00 in BCD
			pm <= 1'b0; // AM
		end
		else if (ena)
		begin
			ss <= ss + 1;
			if (ss == 8'b01101000) // 60 in BCD
			begin
				ss <= 8'b00000000; // 00 in BCD
				mm <= mm + 1;
				if (mm == 8'b11011000) // 60 in BCD
				begin
					mm <= 8'b00000000; // 00 in BCD
					hh <= hh + 1;
					if (hh == 8'b00011000) // 13 in BCD
					begin
						hh <= 8'b00000000; // 01 in BCD
						pm <= ~pm; // Toggle am/pm indicator
					end
				end
			end
		end
	end
	
endmodule
