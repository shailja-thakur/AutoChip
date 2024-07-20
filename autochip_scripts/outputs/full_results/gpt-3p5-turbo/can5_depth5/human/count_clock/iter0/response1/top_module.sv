module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal signal declarations
	reg [7:0] hour_counter;
	reg [7:0] min_counter;
	reg [7:0] sec_counter;
	reg [1:0] hour;
	reg [1:0] min;
	reg [1:0] sec;

	// Counter logic
	always @(posedge clk) begin
		if (reset) begin
			hour_counter <= 8'b00011000; // 12:00 AM
			min_counter <= 8'b00000000;
			sec_counter <= 8'b00000000;
		end else if (ena) begin
			if (sec_counter == 8'b00111001) begin // end of minute
				sec_counter <= 8'b00000000;
				if (min_counter == 8'b01111001) begin // end of hour
					min_counter <= 8'b00000000;
					if (hour_counter == 8'b00011011) // end of day
						hour_counter <= 8'b00011000; // wrap to 12:00 AM
					else
						hour_counter <= hour_counter + 1;
				end else
					min_counter <= min_counter + 1;
			end else
				sec_counter <= sec_counter + 1;
		end
	end

	// BCD conversion
	always @(hour_counter, min_counter, sec_counter) begin
		hour = (hour_counter >= 8'b11001000) ? hour_counter - 8'b11001000 : hour_counter;
		min = (min_counter >= 8'b11001000) ? min_counter - 8'b11001000 : min_counter;
		sec = (sec_counter >= 8'b11001000) ? sec_counter - 8'b11001000 : sec_counter;
	end

	// AM/PM indicator
	always @(hour_counter) begin
		pm = (hour_counter[7]) ? 1'b1 : 1'b0;
	end

	// BCD output
	always @(hour, min, sec) begin
		hh = {4'b0000, hour};
		mm = {4'b0000, min};
		ss = {4'b0000, sec};
	end

endmodule
