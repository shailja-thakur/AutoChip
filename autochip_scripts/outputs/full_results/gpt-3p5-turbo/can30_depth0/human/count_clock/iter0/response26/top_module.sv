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
			hh <= 8'b00010010; // 12
			mm <= 8'b00000000; // 00
			ss <= 8'b00000000; // 00
			pm <= 1'b0; // AM
		end else if (ena) begin
			ss <= ss + 1;
			if (ss >= 8'b01101000) begin // 60
				ss <= 8'b00000000; // 00
				mm <= mm + 1;
				if (mm >= 8'b01101100) begin // 60
					mm <= 8'b00000000; // 00
					hh <= hh + 1;
					if (hh >= 8'b00011010) begin // 12
						hh <= 8'b00010000; // 10
						pm <= ~pm;
					end
				end
			end
		end
	end
endmodule
