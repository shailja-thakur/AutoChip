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
			pm <= 1'b0;
			hh <= 8'b00000001;
			mm <= 8'b00000000;
			ss <= 8'b00000000;
		end else if (ena) begin
			if (ss == 8'b01010111) begin
				ss <= 8'b00000000;
				if (mm == 8'b01010111) begin
					mm <= 8'b00000000;
					if (hh == 8'b00001101) begin
						hh <= 8'b00000001;
						pm <= ~pm;
					end else if (hh == 8'b00001111) begin
						hh <= 8'b00000001;
					end else begin
						hh <= hh + 1;
					end
				end else begin
					mm <= mm + 1;
				end
			end else begin
				ss <= ss + 1;
			end
		end
	end
endmodule
