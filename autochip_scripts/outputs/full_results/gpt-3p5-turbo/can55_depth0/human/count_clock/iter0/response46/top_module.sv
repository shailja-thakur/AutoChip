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
			hh <= 8'b0001; // set initial hour to 01
			mm <= 8'b0000; // set initial minute to 00
			ss <= 8'b0000; // set initial second to 00
		end else if (ena) begin
			ss <= ss + 1;
			if (ss >= 60) begin
				ss <= 8'b0000;
				mm <= mm + 1;
				if (mm >= 60) begin
					mm <= 8'b0000;
					hh <= hh + 1;
					if (hh >= 13) begin
						hh <= 8'b0001;
						pm <= ~pm;
					end
				end
			end
		end
	end
endmodule
