module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			pm <= 1'b0;
			hh <= 8'b0000_1100; // initialize to 12
			mm <= 8'b0000_0000; // initialize to 00
			ss <= 8'b0000_0000; // initialize to 00
		end else if(ena) begin
			// increment seconds
			if(ss == 8'b0101_1001) begin
				ss <= 8'b0000_0000;
				// increment minutes
				if(mm == 8'b0101_1001) begin
					mm <= 8'b0000_0000;
					// increment hours
					if(hh == 8'b0001_0011) begin
						hh <= 8'b0000_0001;
						// toggle am/pm
						pm <= ~pm;
					end else begin
						hh <= hh + 1;
					end
				end else begin
					mm <= mm + 1;
				end
			end else begin
				ss <= ss + 1;
			end
		end
	end

endmodule
