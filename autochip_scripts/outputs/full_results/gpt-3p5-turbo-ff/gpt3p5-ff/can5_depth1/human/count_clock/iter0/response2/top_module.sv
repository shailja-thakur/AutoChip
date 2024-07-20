module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			pm <= 1'b0;
			hh <= 8'd12;
			mm <= 8'd0;
			ss <= 8'd0;
		end else if(ena) begin
			ss <= ss + 1;
			
			if(ss == 8'd59) begin
				ss <= 8'd0;
				mm <= mm + 1;
				
				if(mm == 8'd59) begin
					mm <= 8'd0;
					hh <= hh + 1;
					
					if(hh == 8'd12) begin
						hh <= 8'd1;
						pm <= ~pm;
					end else if(hh == 8'd13) begin
						hh <= 8'd1;
					end
				end
			end
		end
	end

endmodule
