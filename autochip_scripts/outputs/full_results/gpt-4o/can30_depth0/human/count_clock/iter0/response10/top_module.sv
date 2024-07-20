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
			// Reset the clock to 12:00 AM
			hh <= 8'h12; // '12'
			mm <= 8'h00; // '00'
			ss <= 8'h00; // '00'
			pm <= 1'b0;  // AM
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
						pm <= ~pm; // Toggle AM/PM
					end
					else if (hh == 8'h11) begin
						hh <= 8'h12;
					end
					else begin
						hh <= hh + 8'd1;
					end
				end
				else begin
					mm <= mm + 8'd1;
				end
			end
			else begin
				ss <= ss + 8'd1;
			end
		end
	end
endmodule
