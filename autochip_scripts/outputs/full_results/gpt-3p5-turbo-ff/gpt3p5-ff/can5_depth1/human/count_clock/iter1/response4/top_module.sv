module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

	reg [3:0] count_hh;
	reg [5:0] count_mm;
	reg [5:0] count_ss;
	
	always @(posedge clk) begin
		if (reset) begin
			count_hh <= 4'b0000;
			count_mm <= 6'b000000;
			count_ss <= 6'b000000;
			pm <= 0;
		end else if (ena) begin
			if (count_ss == 56'b001110) begin
				count_ss <= 6'b000000;
				count_mm <= count_mm + 1;
				if (count_mm == 6'b010110) begin
					count_mm <= 6'b000000;
					count_hh <= count_hh + 1;
					if (count_hh == 4'b1100) begin
						pm <= ~pm;
						count_hh <= 4'b0000;
					end
				end
			end else begin
				count_ss <= count_ss + 1;
			end
		end
	end
	
	always @* begin
		hh = {count_hh[3], count_hh[2], count_hh[1], count_hh[0]};
		mm = {count_mm[5], count_mm[4], count_mm[3], count_mm[2], count_mm[1], count_mm[0]};
		ss = {count_ss[5], count_ss[4], count_ss[3], count_ss[2], count_ss[1], count_ss[0]};
	end
	
endmodule
