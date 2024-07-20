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
			ss <= ss + 1;
			
			if (ss == 8'b01101000) begin // 60 seconds
				ss <= 8'b00000000;
				mm <= mm + 1;
				
				if (mm == 8'b01101000) begin // 60 minutes
					mm <= 8'b00000000;
					hh <= hh + 1;
					
					if (hh == 8'b00011010) begin // 12 hours
						hh <= 8'b00000001;
						
						if (pm == 1'b0) // AM to PM or PM to AM
							pm <= 1'b1;
						else
							pm <= 1'b0;
					end
				end
			end
		end
	end
	
endmodule
