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
			hh <= 8'b00000000;
			mm <= 8'b00000000;
			ss <= 8'b00000000;
		end else begin
			if (ena) begin
				// increment seconds
				ss <= ss + 1;
				
				// check for PM transition
				if (hh == 8'b00010011 && mm == 8'b00111010 && ss == 8'b00111010) begin
					pm <= ~pm;
				end
				
				// handle seconds overflow
				if (ss == 8'b01100000) begin
					ss <= 8'b00000000;
					// increment minutes
					mm <= mm + 1;
					
					// handle minutes overflow
					if (mm == 8'b01101000) begin
						mm <= 8'b00000000;
						// increment hours
						hh <= hh + 1;
						
						// handle hours overflow
						if (hh == 8'b00011000) begin
							hh <= 8'b00000000;
						end
					end
				end
			end
		end
	end
	
endmodule
