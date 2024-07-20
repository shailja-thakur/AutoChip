module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal signal to keep track of time in seconds
	reg [23:0] time;

	always @(posedge clk) begin
		// Reset the clock to "12:00 AM" when reset is asserted
		if (reset) begin
			time <= 0;
			hh <= 8'b0001_0010;  // 12 in BCD
			mm <= 8'b0000_0000;  // 00 in BCD
			ss <= 8'b0000_0000;  // 00 in BCD
			pm <= 0;
		end
		// Increment the clock when ena is asserted
		else if (ena) begin
			time <= time + 1;

			if (time >= 86400)  // Reset to "12:00 AM" after 24 hours
				time <= 0;

			// Update the BCD digits for hours, minutes, and seconds
			hh <= ((time / 3600) % 12) < 10 ? {(4'b0000), (4'b0), (4'b0), (4'b0)} : {(4'b0000), (b[(time / 3600) % 12][3:0])};
			mm <= ((time / 60) % 60) < 10 ? {(4'b0000), (4'b0), (4'b0), (4'b0)} : {(4'b0000), (b[(time / 60) % 60][3:0])};
			ss <= (time % 60) < 10 ? {(4'b0000), (4'b0), (4'b0), (4'b0)} : {(4'b0000), (b[time % 60][3:0])};

			// Update the PM indicator based on the current hour
			pm <= (time / 3600) >= 12;
		end
	end

	// BCD conversion table to convert decimal digits to BCD
	reg [3:0] b [60] = {4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001,
	                    4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001, 4'b0001,
	                    4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001, 4'b0001, 4'b0010,
	                    4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001, 4'b0010, 4'b0011, 4'b0100,
	                    4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110,
	                    4'b0111, 4'b1000, 4'b1001, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001};

endmodule
