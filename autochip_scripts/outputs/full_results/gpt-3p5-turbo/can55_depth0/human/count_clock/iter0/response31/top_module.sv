module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	reg [3:0] hour_tens;
	reg [3:0] hour_ones;
	reg [3:0] min_tens;
	reg [3:0] min_ones;
	reg [3:0] sec_tens;
	reg [3:0] sec_ones;

	always @(posedge reset or posedge clk) begin
		if (reset) begin
			pm <= 0;
			hh <= 8'b0001_0010;
			mm <= 8'b0000_0000;
			ss <= 8'b0000_0000;
		end else if (ena) begin
			if (ss >= 8'b0101_1001) begin
				ss <= 8'b0000_0000;
				if (mm >= 8'b0101_1001) begin
					mm <= 8'b0000_0000;
					if (hh >= 8'b0001_0001) begin
						pm <= ~pm;
						hh <= 8'b0000_0001;
					end else begin
						hh <= hh + 8'b0000_0001;
					end
				end else begin
					mm <= mm + 8'b0000_0001;
				end
			end else begin
				ss <= ss + 8'b0000_0001;
			end
		end
	end

	always @* begin
		hour_tens = hh[7:4];
		hour_ones = hh[3:0];
		min_tens = mm[7:4];
		min_ones = mm[3:0];
		sec_tens = ss[7:4];
		sec_ones = ss[3:0];
	end

endmodule
