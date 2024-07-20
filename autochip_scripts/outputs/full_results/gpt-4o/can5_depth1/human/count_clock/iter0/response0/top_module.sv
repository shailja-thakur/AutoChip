module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal registers
	reg [3:0] sec_lo, sec_hi;
	reg [3:0] min_lo, min_hi;
	reg [3:0] hour_lo, hour_hi;

	always @(posedge clk) begin
		if (reset) begin
			// Synchronous reset
			sec_lo <= 4'd0;
			sec_hi <= 4'd0;
			min_lo <= 4'd0;
			min_hi <= 4'd0;
			hour_lo <= 4'd2;
			hour_hi <= 4'd1;
			pm <= 1'b0;
		end else if (ena) begin
			// Seconds logic
			if (sec_lo == 4'd9) begin
				sec_lo <= 4'd0;
				if (sec_hi == 4'd5) begin
					sec_hi <= 4'd0;
					// Minutes logic
					if (min_lo == 4'd9) begin
						min_lo <= 4'd0;
						if (min_hi == 4'd5) begin
							min_hi <= 4'd0;
							// Hours logic
							if (hour_lo == 4'd9 || (hour_hi == 4'd1 && hour_lo == 2'd2)) begin
								hour_lo <= 4'd0;
								if (hour_hi == 4'd1) begin
									hour_hi <= 4'd0;
									pm <= ~pm;
								end else begin
									hour_hi <= hour_hi + 1'b1;
								end
							end else begin
								hour_lo <= hour_lo + 1'b1;
							end
						end else begin
							min_hi <= min_hi + 1'b1;
						end
					end else begin
						min_lo <= min_lo + 1'b1;
					end
				end else begin
					sec_hi <= sec_hi + 1'b1;
				end
			end else begin
				sec_lo <= sec_lo + 1'b1;
			end
		end
		// Combine the BCD digits into the output registers
		ss <= {sec_hi, sec_lo};
		mm <= {min_hi, min_lo};
		hh <= {hour_hi, hour_lo};
	end
endmodule
