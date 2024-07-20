module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);
	
	always @(posedge clk) begin
		if (reset)
			pm <= 0;
		else if (ena)
			pm <= (hh == 7'h0C && mm == 7'h00 && ss == 7'h00) ? ~pm : pm;
		
		if (reset || ena) begin
			if (ss == 7'h59) begin
				ss <= 7'h00;
				if (mm == 7'h59) begin
					mm <= 7'h00;
					if (hh == 7'h11)
						hh <= 7'h01;
					else if (hh == 7'h0B)
						hh <= 7'h0C;
					else
						hh <= hh + 1;
				end
				else
					mm <= mm + 1;
			end
			else
				ss <= ss + 1;
		end
	end
	
endmodule
