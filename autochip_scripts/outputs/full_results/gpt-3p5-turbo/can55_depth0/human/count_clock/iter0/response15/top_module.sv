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
			hh <= 8'b0001;
			mm <= 8'b0011;
			ss <= 8'b0000;
			pm <= 1'b0;
		end else if (ena) begin
			ss <= ss + 1;
			
			if (ss == 8'b0110) begin
				ss <= 8'b0000;
				mm <= mm + 1;
				
				if (mm == 8'b0110) begin
					mm <= 8'b0000;
					hh <= hh + 1;
					
					if (hh == 8'b0010) begin
						hh <= 8'b0001;
						
						if (pm == 1'b0) begin
							pm <= 1'b1;
						end else begin
							pm <= 1'b0;
						end
					end
				end
			end
		end
	end
endmodule
