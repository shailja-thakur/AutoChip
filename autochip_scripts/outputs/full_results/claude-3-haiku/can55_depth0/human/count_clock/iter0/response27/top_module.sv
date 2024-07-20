module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss
);

// Seconds counter
always @(posedge clk) begin
	if (reset) begin
		ss <= 8'h00;
	end else if (ena) begin
		if (ss == 8'h59) begin
			ss <= 8'h00;
		end else begin
			ss <= ss + 8'h01;
		end
	end
end

// Minutes counter
always @(posedge clk) begin
	if (reset) begin
		mm <= 8'h00;
	end else if (ena) begin
		if (ss == 8'h59) begin
			if (mm == 8'h59) begin
				mm <= 8'h00;
			end else begin
				mm <= mm + 8'h01;
			end
		end
	end
end

// Hours counter
always @(posedge clk) begin
	if (reset) begin
		hh <= 8'h12;
		pm <= 1'b0;
	end else if (ena) begin
		if (mm == 8'h59 && ss == 8'h59) begin
			if (hh == 8'h12) begin
				hh <= 8'h01;
				pm <= ~pm;
			end else begin
				hh <= hh + 8'h01;
			end
		end
	end
end

endmodule
