module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	reg [3:0] hour_tens;
	reg [3:0] hour_ones;
	reg [3:0] min_tens;
	reg [3:0] min_ones;
	reg [3:0] sec_tens;
	reg [3:0] sec_ones;

	always @(posedge clk or posedge reset) begin
		if (reset)
			begin
			hour_tens <= 4'b0000;
			hour_ones <= 4'b0000;
			min_tens <= 4'b0000;
			min_ones <= 4'b0000;
			sec_tens <= 4'b0000;
			sec_ones <= 4'b0000;
			end
		else if (ena)
			begin
			if (sec_ones == 4'b1001)
				begin
				sec_ones <= 4'b0000;
				if (sec_tens == 4'b1001)
					begin
					sec_tens <= 4'b0000;
					if (min_ones == 4'b1001)
						begin
						min_ones <= 4'b0000;
						if (min_tens == 4'b0101)
							begin
							min_tens <= 4'b0000;
							if (hour_ones == 4'b1001)
								begin
								hour_ones <= 4'b0000;
								if (hour_tens == 4'b0001)
									begin
									hour_tens <= 4'b0000;
									end
								else
									begin
									hour_tens <= hour_tens + 1;
									end
								end
							else
								begin
								hour_ones <= hour_ones + 1;
								end
							end
						else
							begin
							min_tens <= min_tens + 1;
							end
						end
					else
						begin
						min_ones <= min_ones + 1;
						end
					end
				else
					begin
					sec_tens <= sec_tens + 1;
					end
				end
			else
				begin
				sec_ones <= sec_ones + 1;
				end
			end
		end

	always @(posedge clk or posedge reset) begin
		if (reset)
			begin
			pm <= 1'b0;
			end
		else
			begin
			if (hour_tens == 4'b0001 && hour_ones >= 4'b0010)
				begin
				pm <= 1'b1;
				end
			else
				begin
				pm <= 1'b0;
				end
			end
		end
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			begin
			hh <= 8'b00000000;
			end
		else
			begin
			if (hour_tens == 4'b0001 && hour_ones >= 4'b0010 && pm)
				begin
				hh <= {4'b0001, hour_ones};
				end
			else
				begin
				hh <= {hour_tens, hour_ones};
				end
			end
		end

	always @(posedge clk or posedge reset) begin
		if (reset)
			begin
			mm <= 8'b00000000;
			end
		else
			begin
			mm <= {min_tens, min_ones};
			end
		end

	always @(posedge clk or posedge reset) begin
		if (reset)
			begin
			ss <= 8'b00000000;
			end
		else
			begin
			ss <= {sec_tens, sec_ones};
			end
		end

endmodule
