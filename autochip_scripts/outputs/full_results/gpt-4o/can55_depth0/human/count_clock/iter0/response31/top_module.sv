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
			ss <= 8'h00; // Initialize seconds to 00
			mm <= 8'h00; // Initialize minutes to 00
			hh <= 8'h12; // Initialize hours to 12
			pm <= 0;     // Initialize to AM
		end else if (ena) begin
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
					end else if (hh == 8'h09) begin
						hh <= hh + 8'h1;
						hh[7:4] <= 1; // Properly carry to 10 for BCD
					end else if (hh == 8'h11) begin
						hh <= 8'h12;
					end else begin
						hh <= hh + 1;
					end
				end else if (mm[3:0] == 4'h9) begin
					mm <= {mm[7:4] + 1, 4'h0}; // Carry minute units to tens
				end else begin
					mm <= mm + 1;
				end
			end else if (ss[3:0] == 4'h9) begin
				ss <= {ss[7:4] + 1, 4'h0}; // Carry second units to tens
			end else begin
				ss <= ss + 1;
			end
		end
	end

endmodule
