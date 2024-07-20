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
			pm <= 1'b0;
			hh <= 8'b00010010; // Set initial hour to 12 (BCD)
			mm <= 8'b00000000; // Set initial minutes to 00 (BCD)
			ss <= 8'b00000000; // Set initial seconds to 00 (BCD)
		end
		else if (ena) begin
			ss <= ss + 1; // Increment seconds
			if (ss >= 8'b01101000) begin // Convert seconds to BCD representation
				ss <= 8'b00000000;
				mm <= mm + 1; // Increment minutes
				if (mm >= 8'b01111000) begin // Convert minutes to BCD representation
					mm <= 8'b00000000;
					hh <= hh + 1; // Increment hours
					if (hh >= 8'b00010010) begin // Convert hours to BCD representation
						hh <= 8'b00000001;
						pm <= ~pm; // Toggle AM/PM indicator
					end
				end
			end
		end
	end

endmodule
