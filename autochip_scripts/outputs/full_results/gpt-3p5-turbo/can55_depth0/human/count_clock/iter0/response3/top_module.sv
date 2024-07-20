module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	reg [3:0] hour1, hour2, min1, min2, sec1, sec2;

	always @(posedge clk or posedge reset) begin
		if (reset)
			pm <= 1'b0;
		else if (ena)
			pm <= (hh[7] && hh[6]);
			
		if (reset) begin
			hour1 <= 4'b0000;
			hour2 <= 4'b0000;
			min1 <= 4'b0000;
			min2 <= 4'b0000;
			sec1 <= 4'b0000;
			sec2 <= 4'b0000;
		end else if (ena) begin
			if (hh[3:0] == 4'b1001 && hh[7])
				hour1 <= 4'b0001;
			else if (hh[7])
				hour1 <= hour1 + 1;
				
			if (hh[3:0] == 4'b0001 && ~hh[7])
				hour1 <= 4'b1001;
			else if (~hh[7])
				hour1 <= hour1 + 1;
				
			if (hh[3:0] == 4'b1001 && hh[7])
				hour2 <= 4'b0001;
			else if (hh[7])
				hour2 <= hour2 + 1;
				
			if (hh[3:0] == 4'b0001 && ~hh[7])
				hour2 <= 4'b1001;
			else if (~hh[7])
				hour2 <= hour2 + 1;
				
			if (mm[3:0] == 4'b1001 && mm[7])
				min1 <= 4'b0001;
			else if (mm[7])
				min1 <= min1 + 1;
				
			if (mm[3:0] == 4'b0001 && ~mm[7])
				min1 <= 4'b1001;
			else if (~mm[7])
				min1 <= min1 + 1;
				
			if (mm[3:0] == 4'b1001 && mm[7])
				min2 <= 4'b0001;
			else if (mm[7])
				min2 <= min2 + 1;
				
			if (mm[3:0] == 4'b0001 && ~mm[7])
				min2 <= 4'b1001;
			else if (~mm[7])
				min2 <= min2 + 1;
				
			if (ss[3:0] == 4'b1001 && ss[7])
				sec1 <= 4'b0001;
			else if (ss[7])
				sec1 <= sec1 + 1;
				
			if (ss[3:0] == 4'b0001 && ~ss[7])
				sec1 <= 4'b1001;
			else if (~ss[7])
				sec1 <= sec1 + 1;
				
			if (ss[3:0] == 4'b1001 && ss[7])
				sec2 <= 4'b0001;
			else if (ss[7])
				sec2 <= sec2 + 1;
				
			if (ss[3:0] == 4'b0001 && ~ss[7])
				sec2 <= 4'b1001;
			else if (~ss[7])
				sec2 <= sec2 + 1;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hh <= 8'b0000_0000;
			mm <= 8'b0000_0000;
			ss <= 8'b0000_0000;
		end else if (ena) begin
			hh <= {pm, hour1, hour2};
			mm <= {min1, min2};
			ss <= {sec1, sec2};
		end
	end

endmodule
