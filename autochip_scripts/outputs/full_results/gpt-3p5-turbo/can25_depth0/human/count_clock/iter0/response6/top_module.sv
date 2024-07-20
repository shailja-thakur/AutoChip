module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	reg [3:0] hours;
	reg [5:0] minutes;
	reg [5:0] seconds;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			pm <= 1'b0;
			hh <= 8'b00000000;
			mm <= 8'b00000000;
			ss <= 8'b00000000;
		end else if (ena) begin
			if (seconds == 6'b111100) begin
				seconds <= 6'b000000;
				if (minutes == 6'b111100) begin
					minutes <= 6'b000000;
					if (hours == 4'b1100) begin
						hours <= 4'b0001;
						pm <= ~pm;
					end else begin
						hours <= hours + 1;
					end
				end else begin
					minutes <= minutes + 1;
				end
			end else begin
				seconds <= seconds + 1;
			end
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hours <= 4'b0001;
			minutes <= 6'b000000;
			seconds <= 6'b000000;
		end
	end

	always @(hours) begin
		if (hours >= 4'b1010) begin
			hh[7:6] <= 2'b11;
			hh[5:3] <= hours - 4'b1010;
		end else begin
			hh[7:6] <= 2'b00;
			hh[5:3] <= hours;
		end
	end

	always @(minutes) begin
		mm[7:4] <= minutes[5:2];
		mm[3:0] <= minutes[1:0];
	end

	always @(seconds) begin
		ss[7:4] <= seconds[5:2];
		ss[3:0] <= seconds[1:0];
	end

endmodule
