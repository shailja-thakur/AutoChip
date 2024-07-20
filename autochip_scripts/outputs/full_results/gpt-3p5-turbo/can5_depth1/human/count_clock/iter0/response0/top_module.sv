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
			hh <= 8'b00000000;  // Reset to 12:00 AM
			mm <= 8'b00000000;
			ss <= 8'b00000000;
			pm <= 1'b0;
		end else if (ena) begin
			if (ss == 8'b00110011 && mm == 8'b00110100 && hh == 8'b00010010) begin  // 12:59:59 PM
				pm <= ~pm;
			end

			ss <= ss + 1;

			if (ss == 8'b00101000) begin  // Reset seconds to 00 when reaching 59
				ss <= 8'b00000000;
				mm <= mm + 1;

				if (mm == 8'b01100000) begin  // Reset minutes to 00 when reaching 59
					mm <= 8'b00000000;
					hh <= hh + 1;

					if (hh == 8'b00011001) begin  // Reset hours to 01 when reaching 12
						hh <= 8'b00000001;
					end
				end
			end
		end
	end
endmodule
