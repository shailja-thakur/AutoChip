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
			pm <= 1'b0;
			hh <= 8'b00000000;
			mm <= 8'b00000000;
			ss <= 8'b00000000;
		end else if (ena) begin
			ss <= ss + 1;
			if (ss == 8'b01101000) begin // check if 59 seconds reached
				ss <= 8'b00000000;
				mm <= mm + 1;
				if (mm == 8'b01101000) begin // check if 59 minutes reached
					mm <= 8'b00000000;
					hh <= hh + 1;
					if (hh == 8'b00011010) begin // check if 12 hours reached
						hh <= 8'b00000001;
						pm <= ~pm; // toggle am/pm indicator
					end
				end
			end
		end
	end
endmodule
