module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal signals
	reg [7:0] hh_reg;
	reg [7:0] mm_reg;
	reg [7:0] ss_reg;

	// Clock pulse generation
	always @(posedge clk) begin
		if (reset)
			{hh_reg, mm_reg, ss_reg} <= 8'h00;
		else if (ena)
			ss_reg <= ss_reg + 1;

		if (ss_reg == 8'h60) begin
			ss_reg <= 8'h00;
			mm_reg <= mm_reg + 1;
		end

		if (mm_reg == 8'h60) begin
			mm_reg <= 8'h00;
			hh_reg <= hh_reg + 1;
		end

		if (hh_reg == 8'h13)
			hh_reg <= 8'h01;
	end

	// AM/PM determination
	always @(posedge clk) begin
		if (hh_reg >= 8'h12)
			pm <= 1'b1;
		else
			pm <= 1'b0;
	end

	// Synchronous assignment to output registers
	always @(posedge clk) begin
		if (reset)
			{hh, mm, ss} <= 8'h00;
		else
			{hh, mm, ss} <= {hh_reg, mm_reg, ss_reg};
	end

endmodule
