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
			// Reset clock to 12:00 AM
			hh <= 8'h12;  // Set hours to 12
			mm <= 8'h00;  // Set minutes to 00
			ss <= 8'h00;  // Set seconds to 00
			pm <= 1'b0;   // Set to AM (PM = 0)
		end
		else if (ena) begin
			// Increment seconds
			if (ss == 8'h59) begin
				ss <= 8'h00;
				// Increment minutes
				if (mm == 8'h59) begin
					mm <= 8'h00;
					// Increment hours
					if (hh == 8'h12) begin
						hh <= 8'h01;
						pm <= ~pm;  // Toggle AM/PM
					end
					else if (hh == 8'h11) begin
						hh <= 8'h12;
					end
					else if ((hh[3:0] == 4'h9) && (hh[7:4] == 4'h0)) begin
						hh <= {hh[7:4] + 1'b1, 4'h0};
					end
					else begin
						hh[3:0] <= hh[3:0] + 1'b1;
					end
				end
				else if ((mm[3:0] == 4'h9) && (mm[7:4] == 4'h5)) begin
					mm <= {mm[7:4], 4'h0};
				end
				else begin
					mm[3:0] <= mm[3:0] + 1'b1;
				end
			end
			else if ((ss[3:0] == 4'h9) && (ss[7:4] == 4'h5)) begin
				ss <= {ss[7:4], 4'h0};
			end
			else begin
				ss[3:0] <= ss[3:0] + 1'b1;
			end
		end
	end

endmodule
