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
			hh <= 8'b00010001; // 01
			mm <= 8'b00000000; // 00
			ss <= 8'b00000000; // 00
			pm <= 1'b0; // AM
		end else if (ena) begin
			if (ss == 8'b00111000) begin
				ss <= 8'b00000000;
				mm <= mm + 1;
				if (mm == 8'b01111010) begin
					mm <= 8'b00000000;
					hh <= hh + 1;
					if (hh == 8'b00011010) begin
						hh <= 8'b00000001; // increment hours AM to PM
						pm <= ~pm; // toggle AM/PM indicator
					end else if (hh == 8'b00011011) begin
						hh <= 8'b00010000; // increment hours PM to AM
					end
				end
			end else begin
				ss <= ss + 1;
			end
		end
	end

endmodule
