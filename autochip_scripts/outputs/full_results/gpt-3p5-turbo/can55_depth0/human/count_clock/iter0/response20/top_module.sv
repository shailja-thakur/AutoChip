module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss
);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		pm <= 1'b0;
		hh <= 8'b00000000;
		mm <= 8'b00000000;
		ss <= 8'b00000000;
	end else if (ena) begin
		ss <= ss + 1'b1;
		if (ss == 8'b01111010) begin
			ss <= 8'b00000000;
			mm <= mm + 1'b1;
			if (mm == 8'b01111010) begin
				mm <= 8'b00000000;
				hh <= hh + 1'b1;
				if (hh == 8'b00011010) begin
					hh <= 8'b00000000;
					pm <= ~pm;
				end
			end
		end
	end
end

endmodule
