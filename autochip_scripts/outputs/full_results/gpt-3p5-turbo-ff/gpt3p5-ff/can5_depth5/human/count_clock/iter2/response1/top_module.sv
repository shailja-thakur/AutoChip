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
			hh <= 8'b00000001; // Initialize hours to 12 AM
			mm <= 8'b00000000; // Initialize minutes to 00
			ss <= 8'b00000000; // Initialize seconds to 00
		end else if (ena) begin
			if (ss == 8'b01101001) begin
				ss <= 8'b00000000;
				if (mm == 8'b01101001) begin
					mm <= 8'b00000000;
					if (hh == 8'b00011001) begin
						pm <= ~pm;
						hh <= 8'b00000001;
					end else if (hh == 8'b00010010) begin
						hh <= 8'b00011010;
					end else begin
						hh <= hh + 1'b1;
					end
				end else begin
					mm <= mm + 1'b1;
				end
			end else begin
				ss <= ss + 1'b1;
			end
		end
	end

endmodule
