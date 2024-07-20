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
			hh <= 8'b00010010; // 12 in BCD format
			mm <= 8'b00000000; // 00 in BCD format
			ss <= 8'b00000000; // 00 in BCD format
			pm <= 1'b0; // AM
		end else if (ena) begin
			ss <= ss + 1'b1;
			if (ss >= 8'b01101000) begin // 60 in BCD format
				ss <= 8'b00000000;
				mm <= mm + 1'b1;
				if (mm >= 8'b01101000) begin // 60 in BCD format
					mm <= 8'b00000000;
					hh <= hh + 1'b1;
					if (hh >= 8'b00011010) begin // 13 in BCD format
						hh <= 8'b00010000; // 12 in BCD format
						pm <= ~pm;
					end
				end
			end
		end
	end
	
endmodule
