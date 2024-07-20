module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Define counters for hours, minutes, and seconds
	reg [3:0] hour_tens;
	reg [3:0] hour_ones;
	reg [3:0] min_tens;
	reg [3:0] min_ones;
	reg [3:0] sec_tens;
	reg [3:0] sec_ones;
	
	// Define signals for BCD conversion
	reg [3:0] bcd_tens;
	reg [3:0] bcd_ones;
	
	// Synchronous counter for seconds
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ss <= 4'b0000;
		end else if (ena) begin
			if (ss == 4'b1001) begin
				ss <= 4'b0000;
				
				// Increment minutes
				if (min_ones == 4'b1001) begin
					min_ones <= 4'b0000;
					
					if (min_tens == 4'b0000) begin
						min_tens <= 4'b0001;
					end else if (min_tens == 4'b0001) begin
						min_tens <= 4'b0000;
						
						// Increment hours
						if (hour_ones == 4'b1001) begin
							hour_ones <= 4'b0000;
							
							if (hour_tens == 4'b0000) begin
								hour_tens <= 4'b0001;
							end else if (hour_tens == 4'b0001) begin
								hour_tens <= 4'b0000;
								
								// Check AM/PM
								if (pm) begin
									pm <= 1'b0;
								end else begin
									pm <= 1'b1;
								end
							end
						end else begin
							hour_ones <= hour_ones + 4'b0001;
						end
					end
				end else begin
					min_ones <= min_ones + 4'b0001;
				end
			end else begin
				ss <= ss + 4'b0001;
			end
		end
	end
	
	// BCD conversion for hours
	always @(hour_tens or hour_ones) begin
		bcd_tens = (hour_tens < 4'b1010) ? hour_tens : (hour_tens + 4'b1000);
		bcd_ones = (hour_ones < 4'b1010) ? hour_ones : (hour_ones + 4'b1000);
		
		hh = {bcd_tens, bcd_ones};
	end
	
	// BCD conversion for minutes
	always @(min_tens or min_ones) begin
		bcd_tens = (min_tens < 4'b1010) ? min_tens : (min_tens + 4'b1000);
		bcd_ones = (min_ones < 4'b1010) ? min_ones : (min_ones + 4'b1000);
		
		mm = {bcd_tens, bcd_ones};
	end
	
	// BCD conversion for seconds
	always @(sec_tens or sec_ones) begin
		bcd_tens = (sec_tens < 4'b1010) ? sec_tens : (sec_tens + 4'b1000);
		bcd_ones = (sec_ones < 4'b1010) ? sec_ones : (sec_ones + 4'b1000);
		
		ss = {bcd_tens, bcd_ones};
	end
	
endmodule
