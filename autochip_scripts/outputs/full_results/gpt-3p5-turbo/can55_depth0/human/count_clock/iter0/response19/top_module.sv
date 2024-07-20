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
		hh <= 8'b0001_0010; // set hh to 12
		mm <= 8'b0000_0000; // set mm to 00
		ss <= 8'b0000_0000; // set ss to 00
		pm <= 1'b0; // set pm to AM
	end
	else if (ena) begin
		ss <= ss + 1; // increment seconds
		if (ss == 8'b0110_0100) begin // if ss reaches 60
			ss <= 8'b0000_0000; // reset ss to 00
			mm <= mm + 1; // increment minutes
			if (mm == 8'b0110_0100) begin // if mm reaches 60
				mm <= 8'b0000_0000; // reset mm to 00
				hh <= hh + 1; // increment hours
				if (hh == 8'b0001_0101) begin // if hh reaches 13
					hh <= 8'b0000_0001; // reset hh to 01
				end
				else if (hh == 8'b0001_0010) begin // if hh reaches 12
					pm <= ~pm; // toggle pm
				end
			end
		end
	end
end

endmodule
